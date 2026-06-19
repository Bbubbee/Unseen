extends CanvasLayer

@onready var spawn_msg_timer = $SpawnMsgTimer
@onready var destroy_msg_timer: Timer = $DestroyMsgTimer

const TUTORIAL_MESSAGES = preload("uid://vttxs1g67vj0")
@onready var msgs_center_container = $MsgsCenterContainer

const GLITCH_INSIDE = preload("res://assets/fonts/Glitch inside.otf")
const AIRPLANES_IN_THE_NIGHT_SKY = preload("res://assets/fonts/Airplanes in the Night Sky.ttf")


var check_for_input: bool = false

var current_msg: Label

var messages = [
	["ui_accept", "Space to jump"],
	["up", "Up to glide"],
	["down", "Down to fast fall"]
]
var msgs_index: int

func _ready():
	Events.connect("change_realities", _on_change_reality)
	
	if Events.has_seen_tutorial:
		self.queue_free()
	else: 
		Events.has_seen_tutorial = true
	

func _on_change_reality(): 
	set_font_based_on_reality(Events.current_reality)
		
		
func set_font_based_on_reality(reality: bool):
	if not current_msg: return 
	
	var font
	if reality: font = AIRPLANES_IN_THE_NIGHT_SKY
	else: font = GLITCH_INSIDE
	
	current_msg.add_theme_font_override("font", font)


func _on_spawn_msg_timer_timeout():
	if msgs_index+1 <= messages.size():
		current_msg = TUTORIAL_MESSAGES.instantiate()
		set_font_based_on_reality(Events.current_reality)
		current_msg.init(messages[msgs_index][1])
		msgs_center_container.add_child(current_msg)
		destroy_msg_timer.start(5)
		check_for_input = true
	

func _on_destroy_msg_timer_timeout():
	if current_msg:
		current_msg.destroy()
		spawn_msg_timer.start()
		msgs_index += 1
	
	
func _input(event):		
	if not check_for_input: return
	
	if (event.is_action_pressed(str(messages[msgs_index][0]))):
		check_for_input = false
		if destroy_msg_timer.time_left <= 3: return
		destroy_msg_timer.stop()
		destroy_msg_timer.start(3)

	
