extends Control

@onready var high_score_label: Label = $HighScoreLabel

func _ready() -> void:	
	high_score_label.text = "Highscore: " + str(SaveLoad.highest_score)


func _on_start_button_pressed() -> void:
	SceneTransition.change_scene("res://scenes/main.tscn", "dissolve_black")
