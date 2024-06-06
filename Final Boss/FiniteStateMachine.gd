extends Node2D

var current_state: BossState
var previous_state: BossState

func _ready():
	current_state = get_child(0) as BossState
	previous_state = current_state
	current_state.on_enter()

func change_state(state):
	current_state = find_child(state) as BossState
	current_state.on_enter()
	
	previous_state.on_exit()
	previous_state = current_state
