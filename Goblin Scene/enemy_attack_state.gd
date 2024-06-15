class_name EnemyAttackState
extends GoblinState

@export var actor: Enemy
@export var animator: AnimatedSprite2D

func _ready():
	set_physics_process(false)

func on_enter() -> void:
	set_physics_process(true)
	animator.play("explode")

func on_exit() -> void:
	set_physics_process(false)

func _on_animated_sprite_2d_animation_finished():
	actor.player.take_damage(3)
	actor.queue_free()
