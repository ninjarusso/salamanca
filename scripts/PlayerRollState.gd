class_name PlayerRollState
extends State

@export var idle_state : State

func on_enter() -> void:
	super()
	animate2d.animation = "dash"
	move_speed = 550
	
func process_physics(delta : float) -> State:
	process_movement()
	return null

func process_movement() -> void:
	character.velocity = character.direction * move_speed


func _on_animated_sprite_2d_animation_finished():
		next_state = idle_state
