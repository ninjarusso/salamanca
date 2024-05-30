class_name FiniteStateMachine
extends Node

@export var state: State

func _ready():
	change_state(state)

@onready var ray_cast_2d = $RayCast2D

func change_state(new_state: State):
	if state is State:
		state.on_enter()
	new_state.on_exit()
	state = new_state
