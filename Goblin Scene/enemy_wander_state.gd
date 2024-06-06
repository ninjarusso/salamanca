class_name EnemyWanderState
extends GoblinState

@export var actor: Enemy
@export var animator: AnimatedSprite2D
@export var vision_cast: RayCast2D

@onready var player = get_parent().find_child("Player")

signal found_player

func _ready():
	set_physics_process(false)

func on_enter() -> void:
	set_physics_process(true)
	animator.play("move")
	if actor.velocity == Vector2.ZERO:
		actor.velocity = Vector2.RIGHT.rotated(randf_range(0, TAU)) * actor.max_speed

func on_exit() -> void:
	set_physics_process(false)

func _physics_process(delta):
	animator.scale.x = -sign(actor.velocity.x)
	if animator.scale.x == 0.0: animator.scale.x == 1.0
	var collision = actor.move_and_collide(actor.velocity * delta)
	actor.velocity = actor.velocity.move_toward(actor.velocity.normalized() * actor.max_speed, actor.acceleration * delta)
	if collision:
		var bounce_velocity = actor.velocity.bounce(collision.get_normal())
		actor.velocity = bounce_velocity
	if not vision_cast.is_colliding():
		found_player.emit()
