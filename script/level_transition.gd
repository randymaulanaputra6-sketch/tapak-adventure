extends CanvasLayer

@onready var _anim: AnimationPlayer = $AnimationPlayer

var _sibuk := false


func _ready() -> void:
	_anim.play("fade_from_black")


func ganti_scene(tujuan) -> void:
	if _sibuk:
		return

	_sibuk = true
	_anim.play("fade_to_black")
	await _anim.animation_finished

	get_tree().paused = false
	if tujuan is PackedScene:
		get_tree().change_scene_to_packed(tujuan)
	else:
		get_tree().change_scene_to_file(tujuan)

	await get_tree().process_frame
	_anim.play("fade_from_black")
	await _anim.animation_finished
	_sibuk = false
