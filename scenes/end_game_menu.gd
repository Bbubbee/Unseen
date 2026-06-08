extends CanvasLayer

@onready var restart_button: Button = $VBoxContainer/RestartButton
@onready var end_button: Button = $VBoxContainer/EndButton
@onready var highscore_label: Label = $VBoxContainer/HighscoreLabel

# Fonts.
const GLITCH_INSIDE = preload("res://assets/fonts/Glitch inside.otf")
const AIRPLANES_IN_THE_NIGHT_SKY = preload("res://assets/fonts/Airplanes in the Night Sky.ttf")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.connect("game_over", _on_game_over)
	self.visible = false
	

func _on_game_over():
	# Sets the font based on the current reality.
	var font 

	if Events.current_reality: 
		font = AIRPLANES_IN_THE_NIGHT_SKY
	else: 
		font = GLITCH_INSIDE
		
	restart_button.add_theme_font_override("font", font)
	end_button.add_theme_font_override("font", font)
	highscore_label.add_theme_font_override("font", font)
	
	self.visible = true
	
	highscore_label.text = "Highscore: " + str(SaveLoad.highest_score)
	
	
	
	
func _on_restart_button_pressed() -> void:
	SceneTransition.change_scene("res://scenes/main.tscn", "dissolve_black")


func _on_end_button_pressed() -> void:
	get_tree().quit()
	
	
	
func _input(event: InputEvent) -> void:
	if not self.visible: return
	
	if event.is_action_pressed("up"): 
		restart_button.grab_focus()
	elif event.is_action_pressed("down"): 
		end_button.grab_focus()
	
	if event.is_action_pressed("ui_accept"):
		if restart_button.has_focus(): 
			_on_restart_button_pressed()
		elif end_button.has_focus():
			_on_end_button_pressed()
	
	
