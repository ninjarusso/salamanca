class_name MinotauroIdleState
extends MinotauroState

signal found_player

func on_enter():
	super()
	character.velocity = Vector2.ZERO
	anim_tree["parameters/conditions/idle"] = true
	anim_tree["parameters/conditions/is_moving"] = false
	
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		found_player.emit()
