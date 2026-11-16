class_name SkinCard
extends Panel

signal minta_beli(skin_id: String)
signal minta_pakai(skin_id: String)

const WARNA_AKTIF := Color(0.15, 0.55, 0.28, 1.0)
const WARNA_MILIK := Color(0.4, 0.4, 0.4, 1.0)
const WARNA_HARGA := Color(0.14, 0.14, 0.14, 1.0)
const WARNA_MAHAL := Color(0.76, 0.2, 0.16, 1.0)

var skin_id := ""

@onready var preview: AnimatedSprite2D = $Preview
@onready var nama: Label = $Nama
@onready var harga: Label = $Harga
@onready var tombol: Button = $Tombol
@onready var tombol_touch: TouchScreenButton = $TombolTouch

func _ready() -> void:
	resized.connect(_atur_tata_letak)
	tombol.pressed.connect(_tekan)
	tombol_touch.pressed.connect(_tekan)
	_atur_tata_letak()

func setup(id: String) -> void:
	skin_id = id
	nama.text = SkinDB.nama(id)
	preview.sprite_frames = SkinDB.preview_frames()
	SkinDB.terapkan(preview, id)
	preview.play("idle")
	refresh()

func refresh() -> void:
	if skin_id.is_empty():
		return

	if Global.skin_dipakai == skin_id:
		tombol.text = "Dipakai"
		tombol.disabled = true
		tombol_touch.visible = false
		_set_harga("Sedang dipakai", WARNA_AKTIF)
	elif Global.punya_skin(skin_id):
		tombol.text = "Pakai"
		tombol.disabled = false
		tombol_touch.visible = true
		_set_harga("Sudah dimiliki", WARNA_MILIK)
	else:
		var biaya := SkinDB.harga(skin_id)
		var mampu := Global.coin >= biaya
		tombol.text = "Beli %d" % biaya
		tombol.disabled = not mampu
		tombol_touch.visible = mampu
		_set_harga("%d koin" % biaya, WARNA_HARGA if mampu else WARNA_MAHAL)

func _set_harga(teks: String, warna: Color) -> void:
	harga.text = teks
	harga.modulate = warna

func _tekan() -> void:
	if skin_id.is_empty():
		return
	if Global.punya_skin(skin_id):
		minta_pakai.emit(skin_id)
	else:
		minta_beli.emit(skin_id)

func _atur_tata_letak() -> void:
	preview.position = Vector2(48.0, size.y * 0.5)
	var lebar := maxf(size.x - 100.0, 48.0)
	tombol_touch.scale = Vector2(lebar / 96.0, 1.0)
	tombol_touch.position = Vector2(88.0, 52.0)
