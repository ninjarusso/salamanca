class_name CapiangoChaseState
extends CapiangoState

@onready var player = get_tree().get_first_node_in_group("Player")

signal player_lost

func on_enter():
	super()
	anim_tree["parameters/conditions/idle"] = false
	anim_tree["parameters/conditions/is_moving"] = true
	
func state_process(delta) -> void:
	character.direction = player.get_global_position() - character.get_global_position()
	character.velocity = (character.direction.normalized() * move_speed * delta)

func _on_player_detection_body_exited(body):
	if body.is_in_group("Player"):
		player_lost.emit()
