extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
var score = 0 

signal increase_difficulty 


func increase_score(): 
	score += 1
	score_label.text = "score: " + str(score)
	
	if score % 15 == 0: 
		increase_difficulty.emit() 
