class_name PomberoAttackState
extends PomberoState

signal player_out_of_range

@onready var buffer_timer = $BufferTimer

var player : Player = null

func on_enter():
	super()
	character.velocity = Vector2.ZERO
	anim_tree["parameters/conditions/attack"] = true

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("interrupt_state", self)
		buffer_timer.start()
		player = body

func on_exit():
	super()
	anim_tree["parameters/conditions/attack"] = false
	buffer_timer.stop()

func _on_attack_range_body_exited(body):
	if body.is_in_group("Player"):
		emit_signal("player_out_of_range")
		player = null

func _on_buffer_timer_timeout():
	emit_signal("interrupt_state", self)
	
func attack():
	if player != null:
		player.take_damage(owner.enemy_damage)
