class_name PomberoHurtState
extends PomberoState

@export var chase_state : PomberoState

func _ready():
	owner.connect("hurt", _on_hurt)
	
func on_enter():
	super()
	character.velocity = Vector2.ZERO
	anim_tree["parameters/conditions/is_hit"] = true

func on_exit():
	anim_tree["parameters/conditions/is_hit"] = false

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "hit":
		next_state = chase_state

func _on_hurt():
	emit_signal("interrupt_state", self)
