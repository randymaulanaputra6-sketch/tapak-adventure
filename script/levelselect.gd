extends Control

const MENU := "res://scene/game_control/game_scene/main_menu.tscn"
const LEVEL_SCENE := "res://scene/levels/level_%d.tscn"

@onready var grid: GridContainer = $Grid
@onready var template: Button = $Grid/Template


func _ready() -> void:
	for i in Global.LEVEL_TERAKHIR:
		var nomor := i + 1
		var tombol := template.duplicate() as Button
		tombol.visible = true
		tombol.text = str(nomor)
		tombol.disabled = nomor > Global.level_terbuka
		tombol.gui_input.connect(_pilih_level.bind(nomor))
		grid.add_child(tombol)

	var kembali := template.duplicate() as Button
	kembali.visible = true
	kembali.text = "Kembali"
	kembali.custom_minimum_size = Vector2(180, 44)
	kembali.gui_input.connect(_kembali)
	$Bawah.add_child(kembali)


func _pilih_level(event: InputEvent, nomor: int) -> void:
	if not (event is InputEventScreenTouch and event.pressed):
		return
	GlobalAudio.play_button_click()
	if nomor > Global.level_terbuka:
		return
	get_tree().change_scene_to_file(LEVEL_SCENE % nomor)


func _kembali(event: InputEvent) -> void:
	if not (event is InputEventScreenTouch and event.pressed):
		return
	GlobalAudio.play_button_click()
	get_tree().change_scene_to_file(MENU)
