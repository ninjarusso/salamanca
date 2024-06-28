class_name Esqueleto
extends Sprite2D

@onready var interaction_area = $InteractionArea

const lines : Array[String] = [
	"Un esqueleto... ¿qué es esto?",
	"Parece una carta...",
	"Para Juan Moreira, Diez mil Pesos Fuertes...",
	"Firma al pie: Don Sardetti",
]

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact():
	DialogueManager.start_dialog(global_position, lines)
	#await DialogueManager.dialog_finished
