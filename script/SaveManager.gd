extends Node

const SAVE_PATH := "res://savegame.json"

func delete_save():
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(SAVE_PATH)

func save_game(data: Dictionary) -> void:
		var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
		var json = JSON.stringify(data)
		file.store_string(json)

func load_game() -> Dictionary:
	if not FileAccess.file_exists(SAVE_PATH):
		return {}

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var text = file.get_as_text()
	var result = JSON.parse_string(text)
	
	if typeof(result) == TYPE_DICTIONARY:
		return result
	
	return {}
