extends CanvasLayer

@onready var score_label: Label = $HBoxContainer/ScoreLabel
@onready var health_label: Label = $HBoxContainer/HealthLabel

var score = 0 

signal increase_difficulty 



func _ready():
	Events.connect("players_health_changed", _on_players_health_changed)
	
	health_label.text = "health: " + str(10)
	

func _on_players_health_changed(change: int): 
	health_label.text = "health: " + str(change) 
	

func increase_score(): 
	score += 1
	score_label.text = "score: " + str(score)
	
	if score % 15 == 0: 
		increase_difficulty.emit() 
