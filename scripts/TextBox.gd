extends MarginContainer

@onready var label = $MarginContainer/Label
@onready var letter_display_timer = $LetterDisplayTimer

const MAX_WIDTH : int = 256

var text : String = ""
var letter_index : int = 0

var letter_time : float = 0.03
var space_time : float = 0.06
var punctuation_time : float = 0.2

signal finished_displaying()

func display_text(text_to_display : String):
	text = text_to_display
	label.text = text_to_display
	
	await resized
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		custom_minimum_size.y = size.y
	
	global_position.x -= size.x /2
	global_position.y -= size.y + 24
	
	label.text = ""
	_display_letter()

func _display_letter():
	label.text += text[letter_index]
	
	letter_index +=1
	if letter_index >= text.length():
		finished_displaying.emit()
		return
	
	match text[letter_index]:
		"!", ".", ",", "?":
			letter_display_timer.start(punctuation_time)
		" ":
			letter_display_timer.start(space_time)
		_:
			letter_display_timer.start(letter_time)


func _on_letter_display_timer_timeout():
	_display_letter()
