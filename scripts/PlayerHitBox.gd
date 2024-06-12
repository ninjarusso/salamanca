class_name PlayerHitBox
extends Area2D

@onready var damage : float = owner.player_damage
@export var player : Player
@export var facing_polygon : CollisionPolygon2D

func _init() -> void:
	collision_layer = 4
	collision_mask = 0

func _ready() -> void:
	player.connect("facing_direction_changed", _on_player_facing_direction_changed)

func _on_player_facing_direction_changed(facing_right : bool):
	if facing_right:
		facing_polygon.scale = facing_polygon.facing_right_scale
	else:
		facing_polygon.scale = facing_polygon.facing_left_scale
