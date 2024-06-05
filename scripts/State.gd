class_name State
extends Node

signal interrupt_state(new_state : State)

var character : CharacterBody2D
var anim_tree : AnimationPlayer
var next_state : State
var move_speed : float

func state_process(delta):
	pass
	
func state_input(event : InputEvent):
	pass

func on_enter() -> void:
	pass

func on_exit() -> void:
	pass

func process_input(event : InputEvent) -> State:
	return null

func process_physics(delta : float) -> State:
	return null
	
func process_frame(delta : float) -> State:
	return null
