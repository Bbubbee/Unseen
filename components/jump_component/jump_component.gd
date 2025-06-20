extends Node2D
class_name JumpComponent

@export var actor: CharacterBody2D
@export var jump_force: float = -200
@export var coyote_time: float = 0.2
@onready var coyote_timer = $CoyoteTimer

var can_jump: bool = false
@onready var buffer_timer = $BufferTimer


func _ready():
	if not actor: set_physics_process(false)


## NOTE: This MUST be called AFTER move_and_slide()

"""
	Requirements: 
		This must be called in the physics function AFTER move_and_slide()
		This handles the logic that determines if a player can jump.
		It handles coyote time and jump buffers. 
"""
func handle_jump():
	if actor.is_on_floor() and not can_jump:
		can_jump = true
	
	# We have left the floor. 
	if not actor.is_on_floor() and coyote_timer.is_stopped():
		coyote_timer.start(coyote_time)
		
	if not buffer_timer.is_stopped(): 
		try_to_jump()
		
			
func _on_coyote_timer_timeout():
	can_jump = false 


"""
	The player is attempting to jump. 
	return: 
		true -> Jump is successful
		false -> Jump is unsuccessful
		Use these return values if you want to transition into another state in a state machine. 
"""
func try_to_jump():	
	print('trying to jump')
	# Wants to jump.
	if can_jump: 
		can_jump = false
		coyote_timer.stop() 		
		actor.velocity.y = jump_force
		buffer_timer.stop()
		return true
	elif buffer_timer.is_stopped(): 
		buffer_timer.start()
	
	return false 

func second_jump(): 
	actor.velocity.y = jump_force
