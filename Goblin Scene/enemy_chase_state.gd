class_name EnemyChaseState
extends GoblinState

@export var actor: Enemy
@export var animator: AnimatedSprite2D
@export var vision_cast: RayCast2D

signal lost_player

func _ready() -> void:
	set_physics_process(false)

func on_enter() -> void:
	set_physics_process(true)
	animator.play("move")

func on_exit() -> void:
	set_physics_process(false)

func _physics_process(delta) -> void:
	animator.scale.x = -sign(actor.velocity.x)
	if animator.scale.x == 0.0: animator.scale.x == 1.0
	var direction = Vector2.ZERO.direction_to(actor.player.position)
	actor.velocity = actor.velocity.move_toward(direction * actor.max_speed, actor.acceleration * delta)
	actor.move_and_slide()
	if vision_cast.is_colliding():
		lost_player.emit()
