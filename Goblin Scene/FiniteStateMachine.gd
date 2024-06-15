class_name FiniteStateMachine
extends Node

@export var state: GoblinState

func _ready():
	change_state(state)

func change_state(new_state: GoblinState):
	if state is GoblinState:
		state.on_exit()
	new_state.on_enter()
	state = new_state
