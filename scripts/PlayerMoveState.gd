class_name PlayerMoveState
extends PlayerState

@export var idle_state : PlayerState
@export var attack_state : PlayerState
@export var roll_state : PlayerState

func on_enter() -> void:
	super()
	anim_tree["parameters/conditions/idle"] = false
	anim_tree["parameters/conditions/is_moving"] = true
	
func process_physics(delta : float) -> PlayerState :
	process_movement()
	if (character.direction == Vector2.ZERO):
		return idle_state
	return null
	
func process_input(event : InputEvent) -> PlayerState:
	if event.is_action_pressed("attack"):
		return attack_state
	if event.is_action_pressed("special action"):
		return roll_state
	return null

func process_movement() -> void:
	character.direction = Input.get_vector("left", "right", "up", "down")
	character.velocity = character.direction * 90
