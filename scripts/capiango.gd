class_name Capiango
extends CharacterBody2D

@export var health : float
@export var enemy_damage : float

@onready var capiango_state_machine = $CapiangoStateMachine as CapiangoStateMachine
@onready var capiango_idle_state = $CapiangoStateMachine/CapiangoIdleState as CapiangoIdleState
@onready var capiango_chase_state = $CapiangoStateMachine/CapiangoChaseState as CapiangoChaseState
@onready var capiango_attack_state = $CapiangoStateMachine/CapiangoAttackState as CapiangoAttackState
@onready var capiango_hurt_state = $CapiangoStateMachine/CapiangoHurtState as CapiangoHurtState
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var sprite : Sprite2D = $Sprite2D

var direction : Vector2 = Vector2.ZERO
var is_dead : bool = false
var move_speed : float

signal hurt
signal dead

func _physics_process(delta):
	if !is_dead:
		if capiango_state_machine.current_state == capiango_chase_state:
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
	capiango_idle_state.connect("found_player", _on_found_player)
	capiango_chase_state.connect("player_lost", _on_player_lost)
	capiango_attack_state.connect("player_out_of_range", _on_player_out_of_range)

func _on_found_player():
	if !is_dead:
		capiango_state_machine.switch_state(capiango_chase_state)
	
func _on_player_lost():
	if !is_dead:
		capiango_state_machine.switch_state(capiango_idle_state)
	
func _on_player_out_of_range():
	if !is_dead:
		capiango_state_machine.switch_state(capiango_chase_state)

func take_damage(damage : float) -> void:
	health -= damage
	if health <= 0:
		emit_signal("dead")
		is_dead = true
	else:
		print(self.name + " has taken " + str(damage) + " damage, " + str(health) + " hp remaining")
		emit_signal("hurt")
