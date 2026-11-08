extends CharacterBody2D

signal healthChange
const SPEED = 100.0
const JUMP_VELOCITY = -300.0
@onready var player_ui : AnimatedSprite2D = $AnimatedSprite2D
var hitungan_lompat : int = 0
var bisa_lompat : bool
var isHurt: bool = false
@export var maxHealth = 3
@onready var currentHealth: int = maxHealth
@onready var effects = $Effects
@onready var hurtTimer = $hurtTimer
@export var knockbackPower: int = 800

func jump():
	velocity.y = JUMP_VELOCITY

func jump_side(x):
	velocity.y = JUMP_VELOCITY
	velocity.x = x

func _ready():
	effects.play("RESET")

func _physics_process(delta: float) -> void:
	
	if velocity.x > 0 or velocity.x < 0:
		player_ui.animation = "lari"
	else:
		player_ui.animation = "idle"

# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		player_ui.animation = "lompat"
	else:
		bisa_lompat = true
		hitungan_lompat = 0


	# Handle jump.
	if Input.is_action_just_pressed("lompat") and bisa_lompat:
		GlobalAudio.play_jump()
		velocity.y = JUMP_VELOCITY
		hitungan_lompat += 1
		if hitungan_lompat > 1:
			bisa_lompat = false


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("kiri", "kanan")
	if direction:
		player_ui.flip_h = direction < 0
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	

func _on_hurtbox_area_entered(area):
	if isHurt: return
	if area.name == "hitbox":
		player_ui.animation = "kena_damage"
		#GlobalAudio.play_take_damage()
		currentHealth -= 1
		if currentHealth > 0:
			GlobalAudio.play_take_damage()
		if currentHealth == 0:
			currentHealth = maxHealth
			Global.kurang_level()
			GlobalAudio.play_mati()
			get_tree().reload_current_scene()
			Global.player_mati_ambil_coin()

		healthChange.emit(currentHealth)
		isHurt = true
		knockback()
		effects.play("hurtblink")
		hurtTimer.start()
		await hurtTimer.timeout
		effects.play("RESET")
		isHurt = false

func knockback():
	var knockbackDirection = -velocity.normalized() * knockbackPower
	velocity = knockbackDirection
	move_and_slide()
