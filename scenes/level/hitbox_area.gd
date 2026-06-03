extends Area2D
class_name HealthHitbox

signal touched_by_player
@onready var collision_shape = $CollisionShape	

func disable():
	collision_shape.set_deferred("disabled", true)
