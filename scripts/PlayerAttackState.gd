class_name PlayerAttackState
extends PlayerState

@onready var attack_timer : Timer = $AttackTimer
@onready var buffer_timer : Timer = $BufferTimer

@export var idle_state : PlayerState

func on_enter() -> void:
	buffer_timer.start()
	attack_timer.start()
	anim_tree["parameters/playback"].travel("attack1")
	character.velocity = Vector2.ZERO
	
func process_physics(delta : float) -> PlayerState:
	if buffer_timer.is_stopped():
		character.direction = Input.get_vector("left", "right", "up", "down")
	return null

func process_input(event : InputEvent) -> PlayerState:
	if event.is_action_pressed("attack"):
		attack_timer.start()
		buffer_timer.start()
	return null

func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == "attack1"):
		if(attack_timer.is_stopped()):
			next_state = idle_state
		else:
			anim_tree["parameters/playback"].travel("attack2")
	if(anim_name == "attack2"):
		next_state = idle_state
