class_name PlayerHurtBox
extends Area2D

func _init() -> void:
	collision_layer = 0
	collision_mask = 8

func _on_area_entered(hitbox : EnemyHitBox) -> void:
	if hitbox == null:
		return
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
		print(hitbox.name)
