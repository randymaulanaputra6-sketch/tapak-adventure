extends Node2D

@export var mute: bool = false

func _ready() -> void:
	if not mute:
		play_music()

func _play(player: AudioStreamPlayer) -> void:
	if not mute:
		player.play()

func play_music() -> void: _play($Music)
func play_jump() -> void: _play($Jump)
func play_coin() -> void: _play($Coin)
func play_mati() -> void: _play($Mati)
func play_end_level() -> void: _play($EndLevel)
func play_take_damage() -> void: _play($TakeDamage)
func play_button_click() -> void: _play($ButtonClick)
func play_trap_chest() -> void: _play($TrapChest)
func play_open_chest() -> void: _play($OpenChest)
func play_coin_chest() -> void: _play($CoinChest)
