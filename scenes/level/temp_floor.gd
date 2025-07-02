extends RigidBody2D


func _process(_delta):
	# Queue free when floor is off the screen. 
	if ((position.x + ($CollisionShape2D.shape.size.x/2))+50) < 0: 
		print('test')
		queue_free()
