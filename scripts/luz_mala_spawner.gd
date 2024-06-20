class_name LuzMalaSpawner
extends AnimatedSprite2D

@onready var luz_mala_scene : PackedScene = preload("res://Goblin Scene/business_goblin.tscn")
@onready var timer = $Timer

@export var health : float

signal hurt
signal dead

var is_dead : bool = false

func _on_timer_timeout():
	if !is_dead:
		var luz_mala = luz_mala_scene.instantiate()
		add_child(luz_mala)

func _on_area_2d_body_entered(body):
	if !is_dead:
		timer.start()
		self.play("active")

func take_damage(damage : float) -> void:
	health -= damage
	if health < 0:
		emit_signal("dead")
		is_dead = true
		self.play("dead")
		set_physics_process(false)
	else:
		print(self.name + " has taken " + str(damage) + " damage, " + str(health) + " hp remaining")
		emit_signal("hurt")
