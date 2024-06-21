class_name Player
extends CharacterBody2D

signal facing_direction_changed(facing_right : bool)
signal dead
signal hurt

@export var direction : Vector2 = Vector2.ZERO
@export var damage_multiplier : float = 1
@export var health : float = 15
@export var player_damage : float = 2

@onready var anim_tree = $AnimationTree
@onready var state_machine = $PlayerStateMachine
@onready var sprite_2d = $Sprite2D

var move_speed : float
var is_dead : bool = false

func _ready():
	state_machine.init(self)

func _physics_process(delta):
	state_machine.process_physics(delta)
	update_facing_direction()
	move_and_slide()

func _process(delta : float):
	state_machine.process_frame(delta)
	
func _unhandled_input(event : InputEvent):
	state_machine.process_input(event)
	
func update_facing_direction() -> void:
	if direction.x > 0:
		sprite_2d.flip_h = false
	elif direction.x < 0:
		sprite_2d.flip_h = true
	emit_signal("facing_direction_changed", !sprite_2d.flip_h)
	
func take_damage(damage : float) -> void:
	health -= damage
	if health <= 0:
		emit_signal("dead")
		is_dead = true
	else:
		print(self.name + " has taken " + str(damage) + " damage, " + str(health) + " hp remaining")
		emit_signal("hurt")

func recover_health(amount: float):
	health += amount
	if health < 5:
		health = 5
	print("Health recovered: ", health)
