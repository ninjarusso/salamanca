class_name BoarIdleState
extends State

@export var wander_timer : Timer
@export var ray : RayCast2D

var has_wondered : bool = false
var new_wander_position : Vector2 = Vector2.ZERO

func on_enter():
	super()
	character.velocity = Vector2.ZERO
	animate2d.animation = "idle"
	wander_timer.start()

func state_process(deltas) -> void:
	pass

func _on_wander_timer_timeout():
	if has_wondered == false:
		wander_timer.start()
		var a = randf_range(0, 1)
		var b = randf_range(0, 1)
		new_wander_position = Vector2(a, b)
		ray.target_position = new_wander_position
