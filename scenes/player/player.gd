extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Audio
@onready var jump: AudioStreamPlayer2D = $Audio/Jump
@onready var landed: AudioStreamPlayer2D = $Audio/Landed
@onready var damaged: AudioStreamPlayer2D = $Audio/Damaged
@onready var footsteps: AudioStreamPlayer2D = $Audio/Footsteps

@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var jump_component: JumpComponent = $JumpComponent
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var fastfall_timer: Timer = $FastfallTimer
@onready var health_component = $HealthComponent


var reality: bool = true


func _ready():
	health_component.connect("died", _on_died)
	Events.set_health.emit(health_component.current_health)
	
	
	if Events.current_reality: animation_player.play("warm_idle")
	else: animation_player.play("cool_idle")
		

	

# Died. 
func _on_died():
	sprite_2d.set_visible(false)
	await damaged.finished
	Events.game_over.emit()
	
	
	queue_free() 


func _physics_process(delta: float) -> void:
	velocity_component.handle_gravity(delta)

	# Movement	
	var direction = Input.get_axis("left", "right")
	if direction: 
		velocity_component.move(delta, direction)
		
		# Player is on the ground. 
		if self.velocity.y == 0 and not footsteps.playing: 
			footsteps.play()
		#else: 
			#footsteps.stop()

	
	else: 
		velocity_component.stop(delta)
		footsteps.stop()
		
	
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
			
	if event.is_action_pressed("down") and fastfall_timer.is_stopped():
		velocity_component.fast_fall()
	
	if event.is_action_released("up"):
		velocity_component.is_hovering = false

# The player has successfully jumped! Change realites.
func _on_jump_component_jumped() -> void:
	jump.play()
	Events.current_reality = not Events.current_reality
	Events.change_realities.emit() 
	Events.players_jump_count_changed.emit(jump_component.jumps) 
	
	
	# Switch reality character sprite.
	if Events.current_reality: 
		animation_player.play("warm_idle")
	else: 
		animation_player.play("cool_idle")
		

# Hacky stupid way of registering getting hit by a danger area. 
func danger_area_hit(): 
	jump_component.restore_jumps() 
	health_component.change_health(-1)
	Events.screen_shake.emit()
	fastfall_timer.start()
	velocity_component.is_hovering = false
	damaged.play()
	
	

func _on_jump_component_jumps_restored():
	Events.players_jump_count_changed.emit(jump_component.total_jumps)


func _on_jump_component_i_have_landed() -> void:
	landed.play()

# Hacky way of using Hurtbox to actually detect good things (extra health) 
func _on_hurtbox_area_entered(area: HealthHitbox) -> void:
	
	if area is HealthHitbox:
		health_component.change_health(+1)
		area.touched_by_player.emit()
		self.velocity.y = -350
		

	
