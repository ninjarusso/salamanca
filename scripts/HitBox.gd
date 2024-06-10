class_name HitBox
extends Area2D

@export var damage : float
@export var character : CharacterBody2D
@export var facing_polygon : CollisionPolygon2D

func _ready():
	monitoring = false
	character.connect("facing_direction_changed", _on_character_facing_direction_changed)

func _on_character_facing_direction_changed(facing_right : bool) -> void:
	if facing_right:
		facing_polygon.scale = facing_polygon.facing_right_scale
	else:
		facing_polygon.scale = facing_polygon.facing_left_scale
