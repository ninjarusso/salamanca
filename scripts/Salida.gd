class_name Salida
extends Area2D

signal capiango_muerto

@onready var capiango : Capiango = get_tree().get_first_node_in_group("Capiango")

var open : bool = false

func _ready():
	capiango.connect("dead", on_capiango_dead)

func on_capiango_dead():
	open = true

func _on_body_entered(body):
	if open == false:
		return
	if body is Player:
		GameManager.transition_to_scene("res://scenes/nivel_2.tscn", body)
