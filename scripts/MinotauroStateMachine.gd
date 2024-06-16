class_name MinotauroStateMachine
extends Node

@export var character : CharacterBody2D
@export var current_state : MinotauroState
@export var anim_tree : AnimationTree

var states : Array[MinotauroState]

func _ready():
	for child in get_children():
		if child is MinotauroState:
			states.append(child)
			child.character = character
			child.anim_tree = anim_tree
			child.direction = character.direction
			child.connect("interrupt_state", on_state_interrupt_state)
		else:
			push_warning("Child " + child.name + " is not State for CharacterStateMachine")
			
func _physics_process(delta):
	if(current_state.next_state != null):
		switch_state(current_state.next_state)
	current_state.state_process(delta)

func switch_state(new_state : MinotauroState):
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
	
func on_state_interrupt_state(new_state : MinotauroState):
	switch_state(new_state)
