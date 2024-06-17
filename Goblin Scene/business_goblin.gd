class_name Enemy
extends CharacterBody2D

@export var acceleration : float
@export var health : float = 1.0
@export var enemy_damage : float = 1.0

@onready var ray_cast_2d = $RayCast2D
@onready var finite_state_machine = $FiniteStateMachine as FiniteStateMachine
@onready var enemy_wander_state = $FiniteStateMachine/EnemyWanderState as EnemyWanderState
@onready var enemy_chase_state = $FiniteStateMachine/EnemyChaseState as EnemyChaseState
@onready var enemy_attack_state = $FiniteStateMachine/EnemyAttackState as EnemyAttackState
@onready var player = get_tree().get_nodes_in_group("Player")[0]
@onready var animated_sprite_2d = $AnimatedSprite2D

var is_dead : bool = false
var player_in_range : bool = false
signal hurt
signal dead

func _ready():
	enemy_wander_state.found_player.connect(finite_state_machine.change_state.bind(enemy_chase_state))
	enemy_chase_state.lost_player.connect(finite_state_machine.change_state.bind(enemy_wander_state))
	enemy_chase_state.explode.connect(finite_state_machine.change_state.bind(enemy_attack_state))

func _physics_process(delta):
	ray_cast_2d.target_position = ((player.get_global_position() - self.get_global_position()) / 2)
	update_facing_direction()
	
func update_facing_direction() -> void:
	if velocity.x > 0:
		animated_sprite_2d.flip_h = false
	elif velocity.x < 0:
		animated_sprite_2d.flip_h = true
	
func take_damage(damage : float) -> void:
	health -= damage
	if health < 0:
		emit_signal("dead")
		is_dead = true
		queue_free()
	else:
		print(self.name + " has taken " + str(damage) + " damage, " + str(health) + " hp remaining")
		emit_signal("hurt")
