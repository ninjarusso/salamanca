class_name PlayerMoveState
extends State

@export var idle_state : State
@export var attack_state : State
@export var roll_state : State

func on_enter() -> void:
	super()
	anim_tree["parameters/conditions/idle"] = false
	anim_tree["parameters/conditions/is_moving"] = true
	move_speed = 400
	
func process_physics(delta : float) -> State :
	process_movement()
	if (character.direction == Vector2.ZERO):
		return idle_state
	return null
	
func process_input(event : InputEvent) -> State:
	if event.is_action_pressed("attack"):
		return attack_state
	if event.is_action_pressed("special action"):
		return roll_state
	return null

func process_movement() -> void:
	character.direction = Input.get_vector("left", "right", "up", "down")
	character.velocity = character.direction * move_speed
