extends Control

@onready var high_score_label: RichTextLabel = $VBoxContainer/HighScoreLabel
@onready var title_label: RichTextLabel = $VBoxContainer/TitleLabel

func _ready() -> void:	
	high_score_label.text = "Highscore: " + str(SaveLoad.highest_score)
	high_score_label.init("Highscore: " + str(SaveLoad.highest_score))
	


func _on_start_button_pressed() -> void:
	SceneTransition.change_scene("res://scenes/main.tscn", "dissolve_black")
