class_name PlayerStateMachine
extends Node

@export var starting_state : PlayerState
@export var current_state : PlayerState

signal state_changed(state : PlayerState)

func init(character : CharacterBody2D) -> void:
	for child in get_children():
		child.character = get_parent()
		child.anim_tree = character.anim_tree
		child.connect("interrupt_state", interrupt_state_change)
		
	change_state(starting_state)
	
func change_state(new_state : PlayerState) -> void:
	emit_signal("state_changed", new_state)
	if current_state:
		current_state.on_exit()
		
	current_state = new_state
	current_state.on_enter()
	current_state.next_state = null
	
func _physics_process(delta):
	if(current_state.next_state != null):
		change_state(current_state.next_state)
	
func process_physics(delta : float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)
		
func process_input(event : InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_frame(delta : float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
 
func interrupt_state_change(new_state : PlayerState) -> void:
	change_state(new_state)
