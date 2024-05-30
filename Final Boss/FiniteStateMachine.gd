extends Node2D

var current_state: State
var previous_state: State

func _ready():
	current_state = get_child(0) as State
	previous_state = current_state
	current_state.on_enter()

func change_state(state):
	current_state = find_child(state) as State
	current_state.on_enter()
	
	previous_state.on_exit()
	previous_state = current_state
