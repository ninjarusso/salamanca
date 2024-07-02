class_name CapiangoHurtBox
extends Area2D

func _ready() -> void:
	self.connect("area_entered", _on_area_entered)
	
func _init() -> void:
	collision_layer = 0
	collision_mask = 4

func _on_area_entered(hitbox : PlayerHitBox) -> void:
	if hitbox == null:
		return
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
		print(hitbox.name)
