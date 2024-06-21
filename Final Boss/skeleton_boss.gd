extends CharacterBody2D

@onready var player = get_tree().get_nodes_in_group("Player")[0]
@onready var animated_sprite = $AnimatedSprite2D
@onready var progress_bar = $UI/ProgressBar

@export var health : float
@export var enemy_damage : float

var direction : Vector2
var is_dead : bool = false

signal hurt
signal dead

#var health: = 10:
	#set(value):
		#health = value
		#progress_bar.value = value
		#if value <= 0:
			#progress_bar.visible = false
			#find_child("FiniteStateMachine").change_state("Death")

func _ready():
	set_physics_process(false)

func _process(_delta):
	direction = player.position - position
	
	if direction.x < 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false

func _physics_process(delta):
	velocity = direction.normalized() * 40
	move_and_collide(velocity * delta)

func take_damage(damage : float) -> void:
	health -= damage
	if health <= 0:
		emit_signal("dead")
		is_dead = true
		find_child("FiniteStateMachine").change_state("Death")
	else:
		print(self.name + " has taken " + str(damage) + " damage, " + str(health) + " hp remaining")
		emit_signal("hurt")
