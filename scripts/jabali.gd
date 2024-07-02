extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

@export var health : float

signal dead
signal hurt

var is_dead : bool = false
var direction : Vector2 = Vector2.ZERO
var move_speed : float

func update_facing_direction() -> void:
	if direction.x > 0:
		animated_sprite_2d.flip_h = false
	elif direction.x < 0:
		animated_sprite_2d.flip_h = true

func _physics_process(delta):
	update_facing_direction()
	move_and_slide()

func take_damage(damage : float) -> void:
	health -= damage
	if health <= 0:
		emit_signal("dead")
		is_dead = true
	else:
		print(self.name + " has taken " + str(damage) + " damage, " + str(health) + " hp remaining")
		emit_signal("hurt")
