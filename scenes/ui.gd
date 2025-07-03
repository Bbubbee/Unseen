extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
var score = 0 

signal increase_difficulty 

@onready var health_label = $HealthLabel


func _ready():
	Events.connect("players_health_changed", _on_players_health_changed)
	

func _on_players_health_changed(change: int): 
	health_label.text = str(change) 
	

func increase_score(): 
	score += 1
	score_label.text = "score: " + str(score)
	
	if score % 15 == 0: 
		increase_difficulty.emit() 
