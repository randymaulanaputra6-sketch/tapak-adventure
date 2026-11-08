extends Control

@onready var option: Panel = $Option
@onready var pause_ui: Panel = $pause_menu


func _ready() -> void:
	hide()
	pause_ui.visible = true
	option.visible = false
	

func resume():
	get_tree().paused = false

func pause():
	get_tree().paused = true
	show()

func _on_resume_pressed() -> void:
	GlobalAudio.play_button_click()
	resume()
	_ready()

func _on_option_pressed() -> void:
	GlobalAudio.play_button_click()
	pause_ui.visible = false
	option.visible = true

func _on_mainmenu_pressed() -> void:
	Global.balik_menu_level()
	GlobalAudio.play_button_click()
	resume()
	get_tree().change_scene_to_file("res://scene/game_control/game_scene/main_menu.tscn")

func _on_pause_pressed() -> void:
	GlobalAudio.play_button_click()
	pause()

func _on_back_opt_pressed() -> void:
	GlobalAudio.play_button_click()
	pause_ui.visible = true
	option.visible = false


func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()
	Global.kurang_level()
	GlobalAudio.play_button_click()
