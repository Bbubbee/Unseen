extends Node2D

const PLATFORM = preload("res://scenes/level/platform/platform.tscn")
const ENEMY = preload("res://scenes/enemy/enemy.tscn")

# Variables. 
@onready var screen_size = get_viewport_rect().size

var current_reality = true
var platform_reality = true

# Nodes.
@onready var platform_timer: Timer = $PlatformTimer
@onready var platforms: Node2D = $Platforms
@onready var player: CharacterBody2D = $Player
@onready var enemy_timer: Timer = $EnemyTimer
@onready var enemies: Node2D = $Enemies


func _on_platform_timer_timeout() -> void:
	platform_timer.start()
	
	# Spawn platform at right of screen at random height.
	var rand_y = get_random_height()
	var p = PLATFORM.instantiate() as Platform
	p.position = Vector2(screen_size.x, rand_y)
	
	# Add platform.
	platforms.add_child(p)
	p.init(platform_reality)
	p.linear_velocity.x = -150
	
	# Make the platform visible if its it's reality. 
	if p.reality == current_reality:
		p.set_visibility(true)
	else:
		p.set_visibility(false)
	
	# Create a platform. Alternate between the two realites. 
	platform_reality = not platform_reality
	

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

func _on_score_timer_timeout() -> void:
	score_timer.start()
	Events.increased_score.emit()
	
