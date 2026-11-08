extends Area2D


func _on_body_entered(body):
	if (body.name == "player"):
		queue_free()
		Global.add_coin()
		GlobalAudio.play_coin()
