extends Node

const SAVE_PATH := "user://savegame.json"
# shortcut: save lama masih di res://, hapus jalur ini setelah semua pemain pindah ke user://
const SAVE_LAMA := "res://savegame.json"

func delete_save():
	for path in [SAVE_PATH, SAVE_LAMA]:
		if FileAccess.file_exists(path):
			DirAccess.remove_absolute(path)

func save_game(data: Dictionary) -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var json = JSON.stringify(data)
	file.store_string(json)

func load_game() -> Dictionary:
	var path := SAVE_PATH
	if not FileAccess.file_exists(path):
		path = SAVE_LAMA
	if not FileAccess.file_exists(path):
		return {}

	var file = FileAccess.open(path, FileAccess.READ)
	var text = file.get_as_text()
	var result = JSON.parse_string(text)
	
	if typeof(result) == TYPE_DICTIONARY:
		return result
	
	return {}
