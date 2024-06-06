class_name BoarState
extends Node

signal interrupt_state(new_state : BoarState)

@export var move_speed : float

var character : CharacterBody2D
var anim_tree : AnimationTree
var next_state : BoarState
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

func process_input(event : InputEvent) -> void:
	pass

func process_physics(delta : float) -> void:
	pass
	
func process_frame(delta : float) -> void:
	pass
