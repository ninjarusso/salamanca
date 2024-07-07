class_name Cartel
extends Sprite2D

@onready var interaction_area = $InteractionArea

const lines : Array[String] = [
	"Los controles para sobrevivir son los siguientes:",
	"A=Izquierda S=Abajo W=Arriba D=Derecha",
	"Espacio=Hacer roll  F=Interactuar",
	"E = atacar(combo de 3 maximo)",
	"\"De nada...\"",
]

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact():
	DialogueManager.start_dialog(global_position, lines)
	await DialogueManager.dialog_finished
