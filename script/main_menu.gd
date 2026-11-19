extends Control

@onready var menu_button: VBoxContainer = $menu_button
@onready var options: Panel = $Options1


func _ready():
	menu_button.visible = true
	options.visible = false


func _tap(event: InputEvent) -> bool:
	return event is InputEventScreenTouch and event.pressed


func _on_start_gui_input(event: InputEvent) -> void:
	if _tap(event):
		GlobalAudio.play_button_click()
		get_tree().change_scene_to_file("res://scene/levels/level_1.tscn")


func _on_level_gui_input(event: InputEvent) -> void:
	if _tap(event):
		GlobalAudio.play_button_click()
		get_tree().change_scene_to_file("res://scene/game_control/game_scene/levelselect.tscn")


func _on_options_gui_input(event: InputEvent) -> void:
	if _tap(event):
		GlobalAudio.play_button_click()
		menu_button.visible = false
		options.visible = true


func _on_exit_gui_input(event: InputEvent) -> void:
	if _tap(event):
		get_tree().quit()


func _on_back_gui_input(event: InputEvent) -> void:
	if _tap(event):
		GlobalAudio.play_button_click()
		_ready()


func _on_reset_gui_input(event: InputEvent) -> void:
	if _tap(event):
		GlobalAudio.play_button_click()
		Global.reset_data()


func _on_skin_gui_input(event: InputEvent) -> void:
	if _tap(event):
		GlobalAudio.play_button_click()
		get_tree().change_scene_to_file("res://scene/game_control/game_scene/shop_skin.tscn")
