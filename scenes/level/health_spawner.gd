extends Node2D

const EXTRA_HEALTH = preload("uid://cjhduto5clmi8")

@onready var screen_size = get_viewport_rect().size


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func spawn_health() -> void:
	print('spawn health')
	
	var extra_health = EXTRA_HEALTH.instantiate() as Health
	var rand_y = Helper.get_random_height_on_screen(screen_size.y, 20)
	extra_health.position = Vector2(screen_size.x, rand_y)
	self.add_child(extra_health)
