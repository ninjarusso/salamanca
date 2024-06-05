class_name PlayerRollState
extends State

@export var idle_state : State

func on_enter() -> void:
	super()
	anim_tree["parameters/conditions/roll"] = true
	move_speed = 550
	
func process_physics(delta : float) -> State:
	process_movement()
	return null

func process_movement() -> void:
	character.velocity = character.direction * move_speed

func _on_animation_tree_animation_finished(anim_name):
	next_state = idle_state
