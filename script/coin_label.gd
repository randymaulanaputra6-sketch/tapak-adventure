extends Label

func get_coin(coin: int) -> void:
	#text = str("coin: ", coin)
	if coin > 0:
		text = str("coin: +", coin)
	else:
		text = str("coin: ", coin)
	
	if coin < 0:
		Global.reset_coin()
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.connect("my_coin", get_coin)
