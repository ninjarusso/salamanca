class_name PlayerIdleState
extends PlayerState

@export var move_state : PlayerState
@export var attack_state : PlayerState

func on_enter() -> void:
	super()
	character.velocity = Vector2.ZERO
	anim_tree["parameters/conditions/idle"] = true
	anim_tree["parameters/conditions/is_moving"] = false

func process_physics(delta : float) -> PlayerState:
	process_movement()
	if (character.direction != Vector2.ZERO):
		return move_state
	return null

func process_input(event : InputEvent) -> PlayerState:
	if event.is_action_pressed("attack"):
		return attack_state
	return null

func process_movement() -> void:
	character.direction = Input.get_vector("left", "right", "up", "down")
	character.velocity = character.direction * move_speed
