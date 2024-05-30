class_name Enemy
extends CharacterBody2D

@export var max_speed = 40.0
@export var acceleration = 50.0

@onready var ray_cast_2d = $RayCast2D
@onready var finite_state_machine = $FiniteStateMachine as FiniteStateMachine
@onready var enemy_wander_state = $FiniteStateMachine/EnemyWanderState as EnemyWanderState
@onready var enemy_chase_state = $FiniteStateMachine/EnemyChaseState as EnemyChaseState
@onready var player = get_parent().find_child("Player")

func _ready():
	enemy_wander_state.found_player.connect(finite_state_machine.change_state.bind(enemy_chase_state))
	enemy_chase_state.lost_player.connect(finite_state_machine.change_state.bind(enemy_wander_state))

func _physics_process(delta):
	ray_cast_2d.target_position = player.position
