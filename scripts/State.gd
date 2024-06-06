class_name PlayerState
extends Node

signal interrupt_state(new_state : PlayerState)

@export var move_speed : float

var character : CharacterBody2D
var anim_tree : AnimationTree
var next_state : PlayerState
var animate2d : AnimatedSprite2D

func state_process(delta):
	pass
	
func state_input(event : InputEvent):
	pass

func on_enter() -> void:
	character.move_speed = move_speed
	pass

func on_exit() -> void:
	pass

func process_input(event : InputEvent) -> PlayerState:
	return null

func process_physics(delta : float) -> PlayerState:
	return null
	
func process_frame(delta : float) -> PlayerState:
	return null
