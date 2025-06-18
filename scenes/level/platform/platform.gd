extends RigidBody2D
class_name Platform

var state: bool


@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func init(s: bool = true): 
	self.state = s
	
	if not state: 
		collision_shape.debug_color = Color.RED


func set_visibility(on: bool = true):
	self.visible = on 
