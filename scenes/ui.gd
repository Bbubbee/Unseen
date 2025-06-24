extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
var score = 0 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.increased_score.connect(_on_increased_score)

func _on_increased_score(): 
	score += 1
	score_label.text = "score: " + str(score)
