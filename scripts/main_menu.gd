extends CanvasLayer

@onready var play_button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/PlayButton
@onready var exit_button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/ExitButton
@onready var panel = $MarginContainer/PanelContainer
@onready var logo = $Logo

func adjust_button_size():
	play_button.rect_min_size = Vector2(200, 100)
	exit_button.rect_min_size = Vector2(200, 100)

func adjust_panel_size():
	panel.rect_min_size = Vector2(200, 200)

func adjust_logo_size():
	logo.rect_min_size = Vector2(400, 200)

func _on_play_button_pressed():
	GameManager.start_game()
	queue_free()


func _on_exit_button_pressed():
	GameManager.exit_game()
