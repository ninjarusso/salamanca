extends Sprite2D

func _on_button_pressed():
	GameManager.main_menu()
	queue_free()
