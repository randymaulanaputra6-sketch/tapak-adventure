extends Area2D



func _on_body_entered(body: Node2D) -> void:
	Global.kurang_level()
	get_tree().reload_current_scene()
	GlobalAudio.play_mati()
