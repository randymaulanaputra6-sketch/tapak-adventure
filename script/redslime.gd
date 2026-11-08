extends CharacterBody2D

const speed : float = 80.0

@onready var animasi : AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast : RayCast2D = $RayCast2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "player"):
		var y_delta = position.y - body.position.y
		#var  x_delta = body.position.x - position.x
		if (y_delta > 70):
			queue_free()
			body.jump()
			GlobalAudio.play_jump()
			Global.kill_enemy_add_coin()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity.x = speed if animasi.flip_h == true else -speed
	move_and_slide()
	flip()

func flip() -> void:
	if ray_cast.is_colliding() == false or is_on_wall() == true:
		animasi.flip_h = !animasi.flip_h
		ray_cast.position = -ray_cast.position
