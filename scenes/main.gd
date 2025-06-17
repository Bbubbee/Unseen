extends Node2D

const PLATFORM = preload("res://scenes/level/platform/platform.tscn")

# Variables. 
@onready var screen_size = get_viewport_rect().size

# Nodes.
@onready var timer: Timer = $Timer
@onready var platforms: Node2D = $Platforms


func _on_timer_timeout() -> void:
	timer.start()
	
	# Spawn platform at right of screen at random height.
	var rand_y = randi_range(0+100, screen_size.y-100)
	var p = PLATFORM.instantiate()
	p.position = Vector2(screen_size.x, rand_y)
	platforms.add_child(p)
