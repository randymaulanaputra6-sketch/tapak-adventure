extends Control

@onready var menu_button: VBoxContainer = $menu_button
@onready var options: Panel = $Options1




# Called when the node enters the scene tree for the first time.
func _ready():
	menu_button.visible = true
	options.visible = false



#pc/keyboard setting

func _on_start_pressed() -> void:
	GlobalAudio.play_button_click()
	get_tree().change_scene_to_file("res://scene/levels/1.tscn")


func _on_setting_pressed() -> void:
	GlobalAudio.play_button_click()
	menu_button.visible = false
	options.visible = true
	

func _on_exit_pressed() -> void:
	get_tree().quit()

#layar sentuh

func _on_touch_screen_button_start_pressed() -> void:
	GlobalAudio.play_button_click()
	get_tree().change_scene_to_file("res://scene/levels/level_1.tscn")


func _on_touch_screen_button_setting_pressed() -> void:
	GlobalAudio.play_button_click()
	menu_button.visible = false
	options.visible = true

func _on_touch_screen_button_exit_pressed() -> void:
	GlobalAudio.play_button_click()
	get_tree().quit()

#setting
func _on_back_options_pressed() -> void:
	GlobalAudio.play_button_click()
	_ready()


func _on_reset_game_data_pressed() -> void:
	GlobalAudio.play_button_click()
	Global.reset_data()
