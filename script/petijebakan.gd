extends Area2D

@onready var peticoin_ui : AnimatedSprite2D = $AnimatedSprite2D
var opened := false

func _on_body_entered(body: Node2D) -> void:
	if opened:
		return
	
	if (body.name == "player"):
		opened = true
		GlobalAudio.play_open_chest()
		peticoin_ui.play("membuka_peti_jebakan")
	
func _on_animated_trapchest_sprite_2d_animation_finished() -> void:
	if peticoin_ui.animation == "membuka_peti_jebakan":
		GlobalAudio.play_trap_chest()
		peticoin_ui.play("peti_jebakan_terbuka")
		Global.peti_ambil_coin()
		
		
