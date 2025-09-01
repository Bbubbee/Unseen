extends Node2D

const PLATFORM = preload("res://scenes/level/platform/platform.tscn")
const ENEMY = preload("res://scenes/enemy/enemy.tscn")

# Variables. 
@onready var screen_size = get_viewport_rect().size

var current_reality = true
var platform_reality = true
var platform_speed: float = 200

# Nodes.
@onready var platforms: Node2D = $Platforms
@onready var player: CharacterBody2D = $Player
@onready var enemy_timer: Timer = $EnemyTimer
@onready var enemies: Node2D = $Enemies

var last_platform: Platform

func _process(_delta):
	if last_platform:
		# TODO: Set range of distance of which platforms can spawn. 
		if last_platform.position.x < screen_size.x - 150:
			spawn_platform()
	else: 
		spawn_platform()



func spawn_platform(): 
	# Spawn platform at right of screen at random height.
	var rand_y = get_random_height()
	var p = PLATFORM.instantiate() as Platform
	p.position = Vector2(screen_size.x, rand_y)
	
	# Set reality of platform
	var reality: bool
	
	# Check if there is a previous platform.
	if not platforms.get_child_count() > 0:
		# There is not a previous platform. This is the first one. Make the reality true. 
		reality = true
	else:
		# There is a previous platform.
		var previous_platform: Platform = platforms.get_child(platforms.get_child_count()-1)
		
		# 80% chance of being the opposite reality.
		var chance = randi_range(0, 100)
		if chance > 80:
			reality = previous_platform.reality
		else:
			reality = not previous_platform.reality
	
	# Add platform.
	platforms.add_child(p)
	p.init(reality)
	
	last_platform = p
	
	p.linear_velocity.x = -platform_speed  # Set speed of platform
	
	# Make the platform visible if its it's reality. 
	if p.reality == current_reality:
		p.set_visibility(true)
	else:
		p.set_visibility(false)

# Flip the reality when a player jumps. 
func _on_player_player_jumped() -> void:
	current_reality = not current_reality  # Flip the realties.
	
	# Make the new reality visible.	
	for p: Platform in platforms.get_children():
		if p.reality == current_reality:
			p.set_visibility(true)
		else:
			p.set_visibility(false)
	
	for e in enemies.get_children():
		if e.reality == current_reality:
			e.set_visibility(true)
		else:
			e.set_visibility(false)
			

func _on_enemy_timer_timeout() -> void:
	enemy_timer.start()
	
	var rand_y = get_random_height()
	var e = ENEMY.instantiate()
	enemies.add_child(e)
	e.position = Vector2(screen_size.x, rand_y)
	
	e.init(platform_reality)
	e.linear_velocity.x = -150
	
	# Make the platform visible if its it's reality. 
	if e.reality == current_reality:
		e.set_visibility(true)
	else:
		e.set_visibility(false)
	


# Choose a random height based on the size of the screen.
func get_random_height():
	return randi_range(0+20, screen_size.y-20)
	
	
	

# Increase score
@onready var score_timer: Timer = $ScoreTimer
@onready var ui: CanvasLayer = $UI
func _on_score_timer_timeout() -> void:
	score_timer.start()
	ui.increase_score()
	
	
	


# Increase difficulty by increasing the speed of the platforms.
# Add 25 to the speed. 
func _on_ui_increase_difficulty() -> void:
	# Cap the speed at 300
	if platform_speed > 300: return
	platform_speed = platform_speed + 25
	
	
