extends Area2D
class_name Hurtbox

"""
	Requirements: 
		* Corresponding hitbox component. 
		* Collision>Mask to be set. Detects hitbox.
"""

signal hit 

func _on_hitbox_entered(hitbox: Hitbox) -> void:
	if not hitbox: return 
	hit.emit() 

func disable():
	monitorable = false 
	monitoring = false
		
