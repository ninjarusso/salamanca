class_name PlayerAttackState
extends State

@onready var attack_timer : Timer = $AttackTimer
@onready var buffer_timer : Timer = $BufferTimer

@export var idle_state : State
var anim_name : String

func on_enter() -> void:
	buffer_timer.start()
	attack_timer.start()
	animate2d.animation = "attack1"
	character.velocity = Vector2.ZERO
	
func process_physics(delta : float) -> State:
	if buffer_timer.is_stopped():
		character.direction = Input.get_vector("left", "right", "up", "down")
	return null

func process_input(event : InputEvent) -> State:
	if event.is_action_pressed("attack"):
		attack_timer.start()
		buffer_timer.start()
	return null


func _on_animated_sprite_2d_animation_finished():	
	anim_name == str(animate2d.animation)
	if(anim_name == "attack1"):
		if(attack_timer.is_stopped()):
			get_parent().change_state(idle_state)
		else:
			animate2d.animation = "attack2"
	if(anim_name == "attack2"):
		get_parent().change_state(idle_state)
