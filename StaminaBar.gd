extends ProgressBar

@onready var stamina_bar = $"."

var can_regen = false
var time_to_wait = 2
var s_timer = 0
var can_start_stimer = true

func _ready():
	stamina_bar.value = stamina_bar.max_value

func _process(delta):
	if can_regen == false && stamina_bar.value != 100 or stamina_bar.value == 0:
		can_start_stimer = true
		if can_start_stimer:
			s_timer += delta
			if s_timer >= time_to_wait:
				can_regen = true
				can_start_stimer = false
				s_timer = 0
	
	if stamina_bar.value == 100:
		can_regen = false
	
	if can_regen == true:
		stamina_bar.value += 0.5
		can_start_stimer = false
		s_timer = 0
		
