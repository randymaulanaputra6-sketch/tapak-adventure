extends Node

const LEVEL_TERAKHIR := 30

var coin: int = 0
signal my_coin(coin: int)

var skin_dimiliki: Array[String] = [SkinDB.ID_DEFAULT]
var skin_dipakai: String = SkinDB.ID_DEFAULT
signal skin_berubah(skin_id: String)

var level: int = 0
var level_terbuka: int = 1
signal my_level(level: int)


func _ready():
	_load()

func reset_data():
	coin = 0
	level_terbuka = 1
	skin_dimiliki.clear()
	skin_dimiliki.append(SkinDB.ID_DEFAULT)
	skin_dipakai = SkinDB.ID_DEFAULT
	SaveManager.delete_save()
	save()
	emit_signal("my_coin", coin)
	emit_signal("skin_berubah", skin_dipakai)

func save():
	var data = {
	"coin": coin,
	"skin_dimiliki": skin_dimiliki,
	"skin_dipakai": skin_dipakai,
	"level_terbuka": level_terbuka
	}
	SaveManager.save_game(data)

func _load():
	var data = SaveManager.load_game()
	
	if data.is_empty():
		return

	coin = int(data.get("coin", 0))
	level_terbuka = clampi(int(data.get("level_terbuka", 1)), 1, LEVEL_TERAKHIR)

	skin_dimiliki.clear()
	for id in data.get("skin_dimiliki", []):
		var skin := str(id)
		if SkinDB.ada(skin) and not skin_dimiliki.has(skin):
			skin_dimiliki.append(skin)
	if not skin_dimiliki.has(SkinDB.ID_DEFAULT):
		skin_dimiliki.push_front(SkinDB.ID_DEFAULT)

	skin_dipakai = str(data.get("skin_dipakai", SkinDB.ID_DEFAULT))
	if not punya_skin(skin_dipakai):
		skin_dipakai = SkinDB.ID_DEFAULT

#kontrol level
func nomor_level(scene: Node) -> int:
	return maxi(1, scene.scene_file_path.get_file().get_basename().trim_prefix("level_").to_int())

func set_level(n: int) -> void:
	level = n
	emit_signal("my_level", level)

func selesaikan_level(n: int) -> void:
	var berikut := mini(n + 1, LEVEL_TERAKHIR)
	if berikut > level_terbuka:
		level_terbuka = berikut
		save()

#kontrol coin
func load_coin() -> void:
	emit_signal("my_coin", coin)
	print(coin)

func reset_coin() -> void:
	coin = 0
	save()
	emit_signal("my_coin", coin)
	print(coin)
	

func add_coin() -> void:
	coin += 1
	save()
	emit_signal("my_coin", coin)
	print(coin)
	

func peti_ambil_coin() -> void:
	coin -= 150
	save()
	emit_signal("my_coin", coin)
	print(coin)

func peti_add_coin() -> void:
	coin += 100
	save()
	emit_signal("my_coin", coin)
	print(coin)

func finish_add_coin() -> void:
	coin += 10
	save()
	emit_signal("my_coin", coin)
	print(coin)

func kill_enemy_add_coin() -> void:
	coin += 2
	save()
	emit_signal("my_coin", coin)
	print(coin)

func player_mati_ambil_coin() -> void:
	coin -= 20
	save()
	emit_signal("my_coin", coin)
	print(coin)

#kontrol skin
func punya_skin(id: String) -> bool:
	return skin_dimiliki.has(id)

func beli_skin(id: String) -> bool:
	if not SkinDB.ada(id) or punya_skin(id):
		return false

	var biaya: int = SkinDB.harga(id)
	if coin < biaya:
		return false

	coin -= biaya
	skin_dimiliki.append(id)
	save()
	emit_signal("my_coin", coin)
	return true

func pakai_skin(id: String) -> bool:
	if not punya_skin(id):
		return false

	skin_dipakai = id
	save()
	emit_signal("skin_berubah", skin_dipakai)
	return true
