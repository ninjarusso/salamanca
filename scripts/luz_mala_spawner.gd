class_name LuzMalaSpawner
extends AnimatedSprite2D

@onready var luz_mala_scene : PackedScene = preload("res://Goblin Scene/business_goblin.tscn")

func _on_timer_timeout():
	var luz_mala = luz_mala_scene.instantiate()
	add_child(luz_mala)
