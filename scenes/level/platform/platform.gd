extends RigidBody2D
class_name Platform

var reality: bool

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite


var warm_4: Rect2i = Rect2i(0, 48, 64, 32)
var cool_4: Rect2i = Rect2i(80, 48, 64, 32)


func init(r: bool = true): 
	self.reality = r
	print(self )
	
	if not r: 
		collision_shape.debug_color = Color.PURPLE
		sprite.texture = preload("res://scenes/tilemap/warm_4.png")
		
	else: 
		collision_shape.debug_color = Color.DEEP_SKY_BLUE
		sprite.texture = preload("res://scenes/tilemap/cool_4.png")
		


func set_visibility(on: bool = true):
	self.visible = on 


func _on_expire_timer_timeout():
	queue_free()
