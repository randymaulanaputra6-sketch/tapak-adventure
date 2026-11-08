extends Control


func _on_button_gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.pressed:
		GlobalAudio.play_button_click()
		print("kena sentuh")


func _on_button_pressed(event) -> void:
	if event is InputEventScreenTouch and event.pressed:
		GlobalAudio.play_button_click()
		print("kena sentuh")
