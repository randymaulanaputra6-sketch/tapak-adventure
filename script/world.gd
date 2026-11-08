extends Node2D

@onready var heartsContainer = $Control/CanvasLayer/heartsContainer
@onready var player = $player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(player.currentHealth)
	player.healthChange.connect(heartsContainer.updateHearts)
	Global.load_coin()
	Global.add_level()
	Global.reset_level()
