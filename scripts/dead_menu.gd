extends CanvasLayer

func _on_jugar_de_nuevo_button_pressed():
	GameManager.transition_to_scene("res://nivel_1.tscn", null)
	queue_free()

func _on_menu_principal_button_pressed():
	GameManager.main_menu()
	queue_free()
