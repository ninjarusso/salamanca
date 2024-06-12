class_name Enemy
extends CharacterBody2D

@export var max_speed = 40.0
@export var acceleration = 50.0
@export var health : float = 7.0
@export var enemy_damage : float = 1.0

@onready var ray_cast_2d = $RayCast2D
@onready var finite_state_machine = $FiniteStateMachine as FiniteStateMachine
@onready var enemy_wander_state = $FiniteStateMachine/EnemyWanderState as EnemyWanderState
@onready var enemy_chase_state = $FiniteStateMachine/EnemyChaseState as EnemyChaseState
@onready var player = get_parent().find_child("Player")

var is_dead : bool = false
signal hurt
signal dead

func _ready():
	enemy_wander_state.found_player.connect(finite_state_machine.change_state.bind(enemy_chase_state))
	enemy_chase_state.lost_player.connect(finite_state_machine.change_state.bind(enemy_wander_state))

func _physics_process(delta):
	ray_cast_2d.target_position = player.position
	
func take_damage(damage : float) -> void:
	health -= damage
	if health < 0:
		emit_signal("dead")
		is_dead = true
		queue_free()
	else:
		print(self.name + " has taken " + str(damage) + " damage, " + str(health) + " hp remaining")
		emit_signal("hurt")
