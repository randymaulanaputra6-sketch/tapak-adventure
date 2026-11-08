extends HSlider

@export var audio_bus_name: String


var audio_bus_id

func _ready():
	audio_bus_id = AudioServer.get_bus_index(audio_bus_name)


func _on_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(audio_bus_id, db)


func mute_music():
	AudioServer.set_bus_mute(
		 AudioServer.get_bus_index("Music"),
		true
	)

func unmute_music():
	AudioServer.set_bus_mute(
		AudioServer.get_bus_index("Music"),
		false
	)
func mute_sfx():
	AudioServer.set_bus_mute(
		AudioServer.get_bus_index("SFX"),
		true
	)

func un_mute_sfx():
	AudioServer.set_bus_mute(
		AudioServer.get_bus_index("SFX"),
		false
	)


#Music
func _on__pressed() -> void:
	GlobalAudio.play_button_click()
	set_value_no_signal(0)
	mute_music()


func _on_unmute_pressed() -> void:
	GlobalAudio.play_button_click()
	set_value_no_signal(100)
	unmute_music()

#SFX
func _on_sfx_0_pressed() -> void:
	GlobalAudio.play_button_click()
	mute_sfx()

func _on_sfx_un_mute_pressed() -> void:
	GlobalAudio.play_button_click()
	un_mute_sfx()
