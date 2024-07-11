extends TileMap

@onready var player : Player = get_tree().get_first_node_in_group("Player")

func _ready():
	player.connect("dead", on_player_dead)
	
func on_player_dead():
	await get_tree().create_timer(2).timeout
	GameManager.transition_to_scene("res://scenes/dead_menu.tscn", null)
