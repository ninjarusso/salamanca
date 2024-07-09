class_name Minotauro
extends CharacterBody2D

@export var health : float
@export var enemy_damage : float
@onready var minotauro_sfx = $Minotauro_sfx

@onready var minotauro_state_machine = $MinotauroStateMachine as MinotauroStateMachine
@onready var minotauro_idle_state = $MinotauroStateMachine/MinotauroIdleState as MinotauroIdleState
@onready var minotauro_chase_state = $MinotauroStateMachine/MinotauroChaseState as MinotauroChaseState
@onready var minotauro_attack_state = $MinotauroStateMachine/MinotauroAttackState as MinotauroAttackState
@onready var minotauro_hurt_state = $MinotauroStateMachine/MinotauroHurtState as MinotauroHurtState

@onready var player = get_tree().get_nodes_in_group("Player")[0]
@onready var sprite : Sprite2D = $Sprite2D

var direction : Vector2 = Vector2.ZERO
var is_dead : bool = false
var move_speed : float

signal hurt
signal dead

func _physics_process(delta):
	if !is_dead:
		if minotauro_state_machine.current_state == minotauro_chase_state:
			direction = player.position - position
			velocity = direction.normalized() * move_speed
		update_facing_direction()
		move_and_slide()

func update_facing_direction() -> void:
	if !is_dead:
		if direction.x < 0:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
		
func _ready():
	minotauro_idle_state.connect("found_player", _on_found_player)
	minotauro_chase_state.connect("player_lost", _on_player_lost)
	minotauro_attack_state.connect("player_out_of_range", _on_player_out_of_range)

func _on_found_player():
	if !is_dead:
		minotauro_state_machine.switch_state(minotauro_chase_state)
		minotauro_sfx.play()
	
func _on_player_lost():
	if !is_dead:
		minotauro_state_machine.switch_state(minotauro_idle_state)
	
func _on_player_out_of_range():
	if !is_dead:
		minotauro_state_machine.switch_state(minotauro_chase_state)

func take_damage(damage : float) -> void:
	health -= damage
	if health <= 0:
		emit_signal("dead")
		is_dead = true
	else:
		print(self.name + " has taken " + str(damage) + " damage, " + str(health) + " hp remaining")
		emit_signal("hurt")
