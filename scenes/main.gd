extends Node2D

const PLATFORM = preload("res://scenes/level/platform/platform.tscn")

# Variables. 
@onready var screen_size = get_viewport_rect().size

var current_state = true
var platform_state = true

# Nodes.
@onready var platform_timer: Timer = $PlatformTimer
@onready var platforms: Node2D = $Platforms
@onready var player: CharacterBody2D = $Player
@onready var enemy_timer: Timer = $EnemyTimer


func _on_platform_timer_timeout() -> void:
	platform_timer.start()
	
	# Spawn platform at right of screen at random height.
	var rand_y = randi_range(0+100, screen_size.y-100)
	var p = PLATFORM.instantiate() as Platform
	p.position = Vector2(screen_size.x, rand_y)
	
	# Add platform.
	platforms.add_child(p)
	p.init(platform_state)
	p.linear_velocity.x = -150
	
	# Make the platform visible if its it's state. 
	if p.state == current_state:
		p.set_visibility(true)
	else:
		p.set_visibility(false)
	
	
	# Create a platform. Alternate between the two states. 
	platform_state = not platform_state
	


func _on_player_player_jumped() -> void:
	current_state = not current_state  # Flip the state. 
	
	# Make the new state visible.	
	for p: Platform in platforms.get_children(): 
		if p.state == current_state:
			p.set_visibility(true)
		else: 
			p.set_visibility(false)
			


func _on_enemy_timer_timeout() -> void:
	#enemy_timer.start()
	pass # Replace with function body.
