class_name Minotauro
extends CharacterBody2D

@export var health : float = 15

@onready var minotauro_state_machine = $MinotauroStateMachine as MinotauroStateMachine
@onready var minotauro_idle_state = $MinotauroStateMachine/MinotauroIdleState as MinotauroIdleState
@onready var minotauro_chase_state = $MinotauroStateMachine/MinotauroChaseState as MinotauroChaseState
@onready var player = get_tree().get_nodes_in_group("Player")[0]
@onready var sprite : Sprite2D = $Sprite2D

var direction : Vector2 = Vector2.ZERO
var is_dead : bool = false
var move_speed : float

signal hurt
signal dead

func _physics_process(delta):
	if minotauro_state_machine.current_state == minotauro_chase_state:
		direction = player.position - position
		velocity = direction.normalized() * move_speed
	update_facing_direction()
	move_and_slide()

func update_facing_direction() -> void:
	if direction.x < 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
		
func _ready():
	minotauro_idle_state.connect("found_player", _on_found_player)
	minotauro_chase_state.connect("player_lost", _on_player_lost)

func _on_found_player():
	minotauro_state_machine.switch_state(minotauro_chase_state)
	
func _on_player_lost():
	minotauro_state_machine.switch_state(minotauro_idle_state)
