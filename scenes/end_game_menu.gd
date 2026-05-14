extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.connect("game_over", _on_game_over)
	self.visible = false
	

func _on_game_over():
	self.visible = true
	
	
func _on_restart_button_pressed() -> void:
	SceneTransition.change_scene("res://scenes/main.tscn", "dissolve_black")


func _on_end_button_pressed() -> void:
	get_tree().quit()
	
