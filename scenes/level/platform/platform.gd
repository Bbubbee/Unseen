extends RigidBody2D
class_name Platform

var reality: bool


@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func init(r: bool = true): 
	self.reality = r
	
	if not reality: 
		collision_shape.debug_color = Color.PURPLE
	else: 
		collision_shape.debug_color = Color.DEEP_SKY_BLUE
		


func set_visibility(on: bool = true):
	self.visible = on 


func _on_expire_timer_timeout():
	queue_free()
