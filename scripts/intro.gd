extends Node2D
@onready var video_stream_player = $VideoStreamPlayer

func _unhandled_input(event):
	if event.is_action_pressed("attack"):
		GameManager.transition_to_scene(GameManager.level_1.resource_path, null)


func _on_video_stream_player_finished():
	GameManager.transition_to_scene(GameManager.level_1.resource_path, null)
	pass # Replace with function body.
