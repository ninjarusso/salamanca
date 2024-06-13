class_name FiniteStateMachine
extends Node

@export var state: GoblinState

func _ready():
	change_state(state)

@onready var ray_cast_2d = $"../RayCast2D"
@onready var player = get_parent().player

func change_state(new_state: GoblinState):
	if state is GoblinState:
		state.on_exit()
	new_state.on_enter()
	state = new_state
	state.player = player
