extends Area2D

@export_enum("Left", "Right", "Bottom") var direction: String


func _on_body_entered(body):
	if body is not Player: return

	var player = body
	
	if direction == "Right":
		player.velocity.x = -800
		player.velocity.y = -300	
	elif direction == "Left": 
		player.velocity.x = 800
		player.velocity.y = -300	
