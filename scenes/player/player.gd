extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

signal player_jumped 

@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var jump_component: JumpComponent = $JumpComponent

var hp  


func _physics_process(delta: float) -> void:
	velocity_component.handle_gravity(delta)

	# Movement
	var direction = Input.get_axis("left", "right")
	if direction: velocity_component.move(delta, direction)
	else: velocity_component.stop(delta)

	move_and_slide()
	
	jump_component.handle_jump()
	
	if Input.is_action_pressed("up"):
		# Only be able to hover if add the end of jump. Velocity > 0: 
		if velocity.y > 0: 
			velocity_component.is_hovering = true
		else: 
			velocity_component.is_hovering = false
			

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if jump_component.try_to_jump():
			velocity_component.is_hovering = false
			
	
	if event.is_action_pressed("down"):
		velocity_component.fast_fall()

	
	if event.is_action_released("up"):
		velocity_component.is_hovering = false

# The player has successfully jumped! Change realites.
func _on_jump_component_jumped() -> void:
	player_jumped.emit()


func _on_hurtbox_hit() -> void:
	velocity.y = -300
	hp -= 1 
		
