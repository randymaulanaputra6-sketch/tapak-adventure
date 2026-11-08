extends Label


func _ready() -> void:
	Global.connect("my_level", get_level)

func get_level(level: int) -> void:
	if level > 0:
		text = str("level ", level)
	else:
		text = str("level ", level)
