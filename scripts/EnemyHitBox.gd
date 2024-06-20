class_name EnemyHitBox
extends Area2D

@onready var damage : float = owner.damage

func _init() -> void:
	collision_layer = 8
	collision_mask = 1
