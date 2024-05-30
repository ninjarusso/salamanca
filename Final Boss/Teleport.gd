extends State

var can_transition: bool = false
@export var animation_player : AnimationPlayer

@onready var player = get_parent().find_child("Player")

func on_enter():
	super()
	animation_player.play("skill")
	await animation_player.animation_finished
	can_transition = true


func teleport():
	owner.position = player.position + Vector2.RIGHT * 40


func transition():
	if can_transition:
		get_parent().change_state("Attack")
		can_transition = false
