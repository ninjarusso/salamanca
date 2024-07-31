class_name Pombero
extends CharacterBody2D

@export var health : float
@export var enemy_damage : float

@onready var pombero_state_machine = $PomberoStateMachine as PomberoStateMachine
@onready var pombero_idle_state = $PomberoStateMachine/PomberoIdleState as PomberoIdleState
@onready var pombero_chase_state = $PomberoStateMachine/PomberoChaseState as PomberoChaseState
@onready var pombero_attack_state = $PomberoStateMachine/PomberoAttackState as PomberoAttackState
@onready var pombero_hurt_state = $PomberoStateMachine/PomberoHurtState as PomberoHurtState

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var sprite : Sprite2D = $Sprite2D
@onready var pomberosfx = $Pomberosfx

var direction : Vector2 = Vector2.ZERO
var is_dead : bool = false
var move_speed : float

signal hurt
signal dead

func _physics_process(delta):
	if !is_dead:
		if pombero_state_machine.current_state == pombero_chase_state:
			direction = player.position - position
			velocity = direction.normalized() * 100
		else:
			velocity = Vector2.ZERO
		
		update_facing_direction()
		move_and_slide()

func update_facing_direction() -> void:
	if !is_dead:
		if direction.x < 0:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
		
func _ready():
	pombero_idle_state.connect("found_player", _on_found_player)
	pombero_chase_state.connect("player_lost", _on_player_lost)
	pombero_attack_state.connect("player_out_of_range", _on_player_out_of_range)

func _on_found_player():
	if !is_dead:
		pombero_state_machine.switch_state(pombero_chase_state)
		pomberosfx.play()
	
func _on_player_lost():
	if !is_dead:
		pombero_state_machine.switch_state(pombero_idle_state)
	
func _on_player_out_of_range():
	if !is_dead:
		pombero_state_machine.switch_state(pombero_chase_state)

func take_damage(damage : float) -> void:
	health -= damage
	if health <= 0:
		emit_signal("dead")
		is_dead = true
	else:
		print(self.name + " has taken " + str(damage) + " damage, " + str(health) + " hp remaining")
		emit_signal("hurt")
