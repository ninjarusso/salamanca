class_name EnemyChaseState
extends GoblinState

@export var actor: Enemy
@export var animator: AnimatedSprite2D
@export var vision_cast: RayCast2D
@onready var player = get_tree().get_first_node_in_group("Player")

signal lost_player
signal explode(body)

func _ready() -> void:
	set_physics_process(false)

func on_enter() -> void:
	set_physics_process(true)
	animator.play("move")

func on_exit() -> void:
	set_physics_process(false)

func _physics_process(delta) -> void:
	var direction = Vector2.ZERO.direction_to(player.get_global_position() - actor.get_global_position())
	actor.velocity = actor.velocity.move_toward(direction * move_speed, actor.acceleration * delta)
	actor.move_and_slide()
	if vision_cast.is_colliding():
		lost_player.emit()

func _on_attack_range_body_entered(body):
	if body.is_in_group("Player"):
		explode.emit()
		actor.player_in_range = true

func _on_attack_range_body_exited(body):
	if body.is_in_group("Player"):
		actor.player_in_range = false
