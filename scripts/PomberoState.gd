class_name PomberoState
extends Node

signal interrupt_state(new_state : PomberoState)

@export var move_speed : float

var character : CharacterBody2D
var anim_tree : AnimationTree
var next_state : PomberoState
var direction : Vector2

func state_process(delta):
	pass
	
func state_input(event : InputEvent):
	pass

func on_enter() -> void:
	character.move_speed = move_speed
	pass

func on_exit() -> void:
	pass
