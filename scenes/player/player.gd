extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

signal player_jumped 

@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var jump_component: JumpComponent = $JumpComponent


func _physics_process(delta: float) -> void:
	velocity_component.handle_gravity(delta)

	# Movement
	var direction = Input.get_axis("left", "right")
	if direction: velocity_component.move(delta, direction)
	else: velocity_component.stop(delta)

	move_and_slide()
	
	jump_component.handle_jump()
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		jump_component.try_to_jump()

# The player has successfully jumped! Change realites.
func _on_jump_component_jumped() -> void:
	player_jumped.emit()
