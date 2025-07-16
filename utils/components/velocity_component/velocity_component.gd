extends Node2D
class_name VelocityComponent 

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var actor: Node2D
@export var speed: float = 200
@export var acceleration: float = 800
@export var friction: float = 800

@export var hover: float = 50 
var is_hovering: bool = false


# Slows to a stop. 
func stop(delta: float): 
	actor.velocity.x = move_toward(actor.velocity.x, 0, friction*delta)

# Only moves in the x direction. 
func move(delta: float, direction: float):
	actor.velocity.x = move_toward(actor.velocity.x, speed*direction, acceleration*delta) 

func handle_gravity(delta: float): 
	if not actor.is_on_floor(): 
		if is_hovering:
			actor.velocity.y = hover
		else:
			actor.velocity.y += gravity * delta
	
func fast_fall():
	actor.velocity.y = 350
