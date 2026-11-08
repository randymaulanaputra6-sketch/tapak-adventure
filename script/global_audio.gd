extends Node2D

@export var mute: bool = false

func _ready():
	if not mute:
		play_music()

func play_music():
	if not mute:
		$Music.play()

func play_jump() -> void:
	if not mute:
		$Jump.play()

func play_coin() -> void:
	if not mute:
		$Coin.play()

func play_mati() -> void:
	if not mute:
		$Mati.play()

func play_end_level() -> void:
	if not mute:
		$EndLevel.play()

func play_take_damage():
	if not mute:
		$TakeDamage.play()

func play_button_click():
	if not mute:
		$ButtonClick.play()

func play_trap_chest():
	if not mute:
		$TrapChest.play()

func play_open_chest():
	if not mute:
		$OpenChest.play()

func play_coin_chest():
	if not mute:
		$CoinChest.play()
