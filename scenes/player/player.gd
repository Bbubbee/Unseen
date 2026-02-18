extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

signal player_jumped 

@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var jump_component: JumpComponent = $JumpComponent
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

var reality: bool = true
var max_hp: int = 3
var hp: int = 3


func _ready():
	health_component.connect("died", _on_died)
	
	if Events.current_reality: animation_player.play("warm_idle")
	else: animation_player.play("cool_idle")
		

	

# Died. 
func _on_died(): 
	queue_free() 


func _physics_process(delta: float) -> void:
	velocity_component.handle_gravity(delta)

	# Movement	
	var direction = Input.get_axis("left", "right")
	if direction: velocity_component.move(delta, direction)
	else: velocity_component.stop(delta)
	
	# Face sprite towards direction moved
	if direction != 0: sprite_2d.flip_h = direction < 0 
	
	if Input.is_action_pressed("up"):
		# Only be able to hover if add the end of jump. Velocity > 0: 
		if velocity.y > 0: 
			velocity_component.is_hovering = true
		else: 
			velocity_component.is_hovering = false
		
	move_and_slide()  # Must be before handle jump. 
	jump_component.handle_jump()
	

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
	Events.current_reality = not Events.current_reality
	Events.change_realities.emit() 
	
	# Switch reality character sprite.
	if Events.current_reality: 
		animation_player.play("warm_idle")
	else: 
		animation_player.play("cool_idle")
		
		
	
	
@onready var health_component = $HealthComponent
func _on_hurtbox_hit() -> void:
	velocity.y = -300
	health_component.change_health(-1)
	# NOTE: Could be bugged.
	jump_component.restore_jumps()
	Events.screen_shake.emit()


# Hacky stupid way of registering getting hit by a danger area. 
func danger_area_hit(): 
	jump_component.restore_jumps() 
	health_component.change_health(-1)
	Events.screen_shake.emit()
		
