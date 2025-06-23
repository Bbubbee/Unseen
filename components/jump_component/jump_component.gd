extends Node2D
class_name JumpComponent

@export var actor: CharacterBody2D
@export var jump_force: float = -200
@export var coyote_time: float = 0.2
@export var total_jumps: int = 2  # Default to double jump

@onready var coyote_timer = $CoyoteTimer
@onready var buffer_timer = $BufferTimer

var jumps := total_jumps
var can_jump_from_ground := false

signal jumped

func _ready():
	if not actor:
		set_physics_process(false)


## Call this AFTER move_and_slide()
func handle_jump():
	if actor.is_on_floor():
		can_jump_from_ground = true
		jumps = total_jumps
	
	if not actor.is_on_floor() and coyote_timer.is_stopped():
		coyote_timer.start(coyote_time)
	
	if not buffer_timer.is_stopped():
		try_to_jump()

func _on_coyote_timer_timeout():
	can_jump_from_ground = false


func try_to_jump():
	if jumps > 0:
		if actor.is_on_floor() or can_jump_from_ground:
			can_jump_from_ground = false
			coyote_timer.stop()

		jumps -= 1
		buffer_timer.stop()
		actor.velocity.y = jump_force
		jumped.emit()
	
	elif buffer_timer.is_stopped():
		buffer_timer.start()
