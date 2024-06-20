class_name EnemyHitBox
extends Area2D

@onready var damage : float = owner.damage

func _init() -> void:
	self.set_monitorable(false)
