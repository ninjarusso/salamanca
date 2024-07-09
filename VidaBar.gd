extends ProgressBar

@onready var timer = $Timer
@onready var vida_bar = $"."

var vida = 0 : set = _set_vida

func _set_vida(new_vida):
	var prev_vida = vida
	vida = min(max_value,new_vida)
	value = vida
		
	if vida < prev_vida:
		timer.start()
	else:
		vida_bar.value = vida

func init_vida(_vida):
	vida = _vida
	max_value = vida
	value = vida
	

func _on_timer_timeout():
	vida_bar.value = vida
