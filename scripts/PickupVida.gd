extends Area2D

@export var health_healed: int = 1.25

func _on_PickupVida_body_entered(body):
	if body.is_in_group("Player"):
		body.recover_health(health_healed)
		queue_free()

func _ready():
	connect("body_entered", _on_PickupVida_body_entered)
