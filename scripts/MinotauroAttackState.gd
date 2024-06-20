class_name MinotauroAttackState
extends MinotauroState

signal player_out_of_range

func on_enter():
	super()
	anim_tree["parameters/conditions/attack"] = true

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("interrupt_state", self)

func on_exit():
	super()
	anim_tree["parameters/conditions/attack"] = false

func _on_attack_range_body_exited(body):
	if body.is_in_group("Player"):
		emit_signal("player_out_of_range")

func _on_buffer_timer_timeout():
	emit_signal("interrupt_state", self)
