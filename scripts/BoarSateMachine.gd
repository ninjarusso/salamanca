class_name BoarStateMachine
extends Node

@export var character : CharacterBody2D
@export var current_state : BoarState
@export var animate2d : AnimatedSprite2D
@export var starting_state : BoarState

var states : Array[BoarState]

func _ready():
	for child in get_children():
		if child is BoarState:
			states.append(child)
			child.character = character
			child.animate2d = animate2d
			child.connect("interrupt_state", on_state_interrupt_state)
		else:
			push_warning("Child " + child.name + " is not State for CharacterStateMachine")
	switch_states(starting_state)
			
func _physics_process(delta):
	if(current_state.next_state != null):
		switch_states(current_state.next_state)
	current_state.state_process(delta)

func switch_states(new_state : BoarState):
	if(current_state != null):
		current_state.on_exit()
		current_state.next_state = null
		
	current_state = new_state
	current_state.on_enter()

func _input(event: InputEvent):
	current_state.state_input(event)

func check_if_can_move():
	return current_state.can_move

func check_if_can_take_damage():
	return current_state.can_take_damage
	
func on_state_interrupt_state(new_state : BoarState):
	switch_states(new_state)
