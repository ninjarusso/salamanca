class_name BoarIdleState
extends BoarState

@onready var wander_timer = $"../../WanderTimer"
@onready var ray = $"../../RayCast2D"

var has_wondered : bool = false
var new_wander_position : Vector2 = Vector2.ZERO

func on_enter():
	super()
	animate2d.animation = "idle"
	wander_timer.start()

func state_process(delta) -> void:
	character.direction = ray.target_position
	character.velocity = character.direction * move_speed

func _on_wander_timer_timeout():	
	if has_wondered == false:
		wander_timer.start()
		#var a = randf_range(0, 1)
		#var b = randf_range(0, 1)
		new_wander_position = Vector2.RIGHT.rotated(randf_range(0, TAU))
		ray.target_position = new_wander_position
