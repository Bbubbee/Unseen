extends RichTextLabel

@onready var unaltered_text: String = self.text

func _ready() -> void:
	chars_set_rand_font()

func init(text: String):
	unaltered_text = text
	chars_set_rand_font()
	
func chars_set_rand_font() -> void:
	var new_text: String
	
	# Iterate through text, assign each character a random font out of two.
	for c in unaltered_text:
		var chance = [true, false].pick_random()
		var c_new_font
		
		if chance: 
			c_new_font = "[font=res://assets/fonts/Airplanes in the Night Sky.ttf]"+str(c)+"[/font]"
		else: 
			c_new_font = "[font=res://assets/fonts/Glitch inside.otf]"+str(c)+"[/font]"
			
		new_text = new_text+c_new_font
	
	self.text = new_text
		
	
	


func _on_timer_timeout() -> void:
	chars_set_rand_font()
