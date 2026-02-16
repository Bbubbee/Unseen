extends CanvasLayer

@onready var score_label: Label = $HBoxContainer/ScoreLabel
@onready var health_label: Label = $HBoxContainer/HealthLabel

const GLITCH_INSIDE = preload("res://assets/fonts/Glitch inside.otf")
const AIRPLANES_IN_THE_NIGHT_SKY = preload("res://assets/fonts/Airplanes in the Night Sky.ttf")

var score = 0 

signal increase_difficulty 


func _ready():
	Events.connect("players_health_changed", _on_players_health_changed)
	Events.connect("change_realities", _on_change_reality)
	
	health_label.text = "HP: " + str(10)
	

func _on_change_reality(reality: bool): 
	if reality:
		score_label.add_theme_font_override("font", GLITCH_INSIDE)
		health_label.add_theme_font_override("font", GLITCH_INSIDE)
		
	else: 
		score_label.add_theme_font_override("font", AIRPLANES_IN_THE_NIGHT_SKY)
		health_label.add_theme_font_override("font", AIRPLANES_IN_THE_NIGHT_SKY)
		
		

func _on_players_health_changed(change: int): 
	health_label.text = "HP: " + str(change) 
	

func increase_score(): 
	score += 1
	score_label.text = "Score: " + str(score)
	
	if score % 15 == 0: 
		increase_difficulty.emit() 
