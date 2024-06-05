class_name PlayerIdleState
extends State

@export var move_state : State
@export var attack_state : State

func on_enter() -> void:
	super()
	character.velocity = Vector2.ZERO
	anim_tree["parameters/conditions/idle"] = true
	anim_tree["parameters/conditions/is_moving"] = false

func process_physics(delta : float) -> State:
	process_movement()
	if (character.direction != Vector2.ZERO):
		return move_state
	return null

func process_input(event : InputEvent) -> State:
	if event.is_action_pressed("attack"):
		return attack_state
	return null

func process_movement() -> void:
	character.direction = Input.get_vector("left", "right", "up", "down")
	character.velocity = character.direction * move_speed
