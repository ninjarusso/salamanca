class_name PlayerDeathState
extends PlayerState

func on_enter():
	super()
	character.velocity = Vector2.ZERO
	anim_tree["parameters/conditions/is_dead"] = true

func _on_player_dead():
	emit_signal("interrupt_state", self)
	character.is_dead = true
