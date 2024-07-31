class_name PlayerRollState
extends PlayerState

@export var idle_state : PlayerState

func on_enter() -> void:
	super()
	anim_tree["parameters/conditions/is_moving"] = false
	anim_tree["parameters/conditions/roll"] = true
	character.set_collision_layer_value(1, false)
	character.set_collision_mask_value(2, false)
	character.set_collision_mask_value(3, false)
	character.set_collision_mask_value(4, false)
	
func process_physics(delta : float) -> PlayerState:
	process_movement()
	return null

func process_movement() -> void:
	character.velocity = character.direction * 200

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "roll":
		emit_signal("interrupt_state", idle_state)


func on_exit():
	anim_tree["parameters/conditions/roll"] = false
	anim_tree["parameters/conditions/is_moving"] = false
	anim_tree["parameters/conditions/idle"] = true
	character.set_collision_layer_value(1, true)
	character.set_collision_mask_value(2, true)
	character.set_collision_mask_value(3, true)
	character.set_collision_mask_value(4, true)
