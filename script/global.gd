extends Node

var coin: int = 0
signal my_coin(coin: int)

var level: int = 0
signal my_level(level: int)


func _ready():
	_load()

func reset_data():
	coin = 0
	#level = 0
	SaveManager.delete_save()
	save()

func save():
	var data = {
	#"level": level,
	"coin": coin
	}
	SaveManager.save_game(data)

func _load():
	var data = SaveManager.load_game()
	
	if data.is_empty():
		return

	coin = data.get("coin", 0)
	#level = data.get("level", 1)

#kontrol level
func add_level() -> void:
	level += 1
	emit_signal("my_level", level)
	print(level)

func kurang_level() -> void:
	level -= 1
	emit_signal("my_level", level)
	print(level)

func balik_menu_level() -> void:
	level = 0
	emit_signal("my_level", level)
	print(level)

func reset_level() -> void:
	if level == 30:
		level = 0

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
