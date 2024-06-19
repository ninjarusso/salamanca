class_name MinotauroAttackState
extends MinotauroState

signal player_out_of_range

@onready var buffer_timer = $BufferTimer

func on_enter():
	super()
	anim_tree["parameters/conditions/attack"] = true
	buffer_timer.start()

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("interrupt_state", self)

func attack():
	character.player.take_damage(character.damage)

func on_exit():
	super()
	anim_tree["parameters/conditions/attack"] = false
	buffer_timer.stop()

func _on_attack_range_body_exited(body):
	if body.is_in_group("Player"):
		emit_signal("player_out_of_range")

func _on_buffer_timer_timeout():
	emit_signal("interrupt_state", self)
