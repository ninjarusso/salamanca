extends State

@export var animation_player : AnimationPlayer

func on_enter():
	super()
	animation_player.play("death")

func boss_slained():
	animation_player.play("boss_slained")
