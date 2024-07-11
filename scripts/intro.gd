extends Node2D

func _unhandled_input(event):
	if event.is_action_pressed("attack"):
		GameManager.transition_to_scene(GameManager.main_menu_screen.resource_path, null)
		
func _on_video_stream_player_finished():
	GameManager.transition_to_scene(GameManager.main_menu_screen.resource_path, null)
