extends Control

const KARTU = preload("res://scene/game_control/game_scene/skin_card.tscn")
const MENU = "res://scene/game_control/game_scene/main_menu.tscn"

@onready var grid: GridContainer = $Scroll/Grid
@onready var koin_label: Label = $Koin/KoinLabel
@onready var pesan: Label = $Pesan
@onready var konfirmasi: Panel = $Konfirmasi
@onready var teks_konfirmasi: Label = $Konfirmasi/Teks

var _id_konfirmasi := ""
var _tween_pesan: Tween

func _ready() -> void:
	$KembaliBox/Kembali.pressed.connect(_kembali)
	$KembaliBox/KembaliTouch.pressed.connect(_kembali)
	$Konfirmasi/Ya.pressed.connect(_beli)
	$Konfirmasi/YaTouch.pressed.connect(_beli)
	$Konfirmasi/Batal.pressed.connect(_batal)
	$Konfirmasi/BatalTouch.pressed.connect(_batal)

	Global.my_coin.connect(_perbarui_koin)
	Global.skin_berubah.connect(_perbarui_kartu)

	konfirmasi.hide()
	pesan.modulate.a = 0.0
	_bangun_kartu()
	_perbarui_koin(Global.coin)

func _bangun_kartu() -> void:
	for id in SkinDB.daftar():
		var kartu := KARTU.instantiate() as SkinCard
		grid.add_child(kartu)
		kartu.setup(id)
		kartu.minta_beli.connect(_minta_beli)
		kartu.minta_pakai.connect(_pakai)

func _perbarui_koin(coin: int) -> void:
	koin_label.text = "Koin: %d" % coin
	_perbarui_kartu()

func _perbarui_kartu(_skin_id: String = "") -> void:
	for anak in grid.get_children():
		var kartu := anak as SkinCard
		if kartu != null:
			kartu.refresh()

func _minta_beli(id: String) -> void:
	var biaya := SkinDB.harga(id)
	if Global.coin < biaya:
		_pesan("Koin tidak cukup")
		return

	_id_konfirmasi = id
	teks_konfirmasi.text = "Beli %s seharga %d koin?" % [SkinDB.nama(id), biaya]
	konfirmasi.show()

func _beli() -> void:
	if _id_konfirmasi.is_empty():
		return

	if Global.beli_skin(_id_konfirmasi):
		GlobalAudio.play_coin_chest()
		_pesan("%s berhasil dibeli" % SkinDB.nama(_id_konfirmasi))
	else:
		_pesan("Koin tidak cukup")

	_batal()

func _pakai(id: String) -> void:
	GlobalAudio.play_button_click()
	if not Global.pakai_skin(id):
		_pesan("Skin belum dimiliki")

func _batal() -> void:
	_id_konfirmasi = ""
	konfirmasi.hide()

func _kembali() -> void:
	GlobalAudio.play_button_click()
	TransisiLevel.ganti_scene(MENU)

func _pesan(teks: String) -> void:
	pesan.text = teks
	pesan.modulate.a = 1.0

	if _tween_pesan != null and _tween_pesan.is_valid():
		_tween_pesan.kill()

	_tween_pesan = create_tween()
	_tween_pesan.tween_interval(1.6)
	_tween_pesan.tween_property(pesan, "modulate:a", 0.0, 0.4)
