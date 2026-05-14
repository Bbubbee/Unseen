extends CanvasLayer

@onready var score_label: Label = $HBoxContainer/ScoreLabel
@onready var health_label: Label = $HBoxContainer/HealthLabel
@onready var jumps_label: Label = $BottomRow/JumpsLabel
@onready var jumps_count_label = $BottomRow/JumpsCountLabel
@onready var animation_player = $AnimationPlayer
@onready var health_counter_label: Label = $HBoxContainer/HealthCounterLabel
@onready var score_counter_label: Label = $HBoxContainer/ScoreCounterLabel

const GLITCH_INSIDE = preload("res://assets/fonts/Glitch inside.otf")
const AIRPLANES_IN_THE_NIGHT_SKY = preload("res://assets/fonts/Airplanes in the Night Sky.ttf")

var score = 0 

signal increase_difficulty 


func _ready():
	Events.connect("players_health_changed", _on_players_health_changed)
	Events.connect("change_realities", _on_change_reality)
	Events.connect("players_jump_count_changed", _on_players_jump_count_changed)
	Events.connect("set_health", _on_set_health)
	
	set_font_based_on_reality(Events.current_reality)
	

func _on_set_health(health: int):
	health_counter_label.set_text(str(health))
		
		
func _on_change_reality(): 
	set_font_based_on_reality(Events.current_reality)
		
		
func set_font_based_on_reality(reality: bool):
	var font
	if reality: font = AIRPLANES_IN_THE_NIGHT_SKY
	else: font = GLITCH_INSIDE

	score_label.add_theme_font_override("font", font)
	health_label.add_theme_font_override("font", font)
	jumps_label.add_theme_font_override("font", font)
	jumps_count_label.add_theme_font_override("font", font)
	health_counter_label.add_theme_font_override("font", font)
	score_counter_label.add_theme_font_override("font", font)
	

func _on_players_health_changed(change: int): 
	health_counter_label.set_text(str(change))
	health_counter_label.flash_red()
	
	
func _on_players_jump_count_changed(jump_count: int):
	var prev_jump_count: int = int(jumps_count_label.text)

	if prev_jump_count > jump_count: 
		animation_player.play("jump_count_flash_red")
	elif prev_jump_count == jump_count: 
		pass
	else: 
		animation_player.play("jump_count_flash_green")

		
	jumps_count_label.text = str(jump_count)


func increase_score(): 
	score += 1
	score_counter_label.text = str(score)
	
	if score % 15 == 0: 
		increase_difficulty.emit() 
	
	if score % 25 == 0: 
		score_counter_label.flash_green()
		
	
