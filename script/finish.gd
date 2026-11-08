extends CharacterBody2D


@export var target_level : PackedScene

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "player"):
		GlobalAudio.play_end_level()
		Global.finish_add_coin()
		get_tree().change_scene_to_packed(target_level)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	move_and_slide()
