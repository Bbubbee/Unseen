extends Node


const SAVE_FILE = 'user://savefile.save'

var highest_score: int = 0

func _ready() -> void:
	load_score()
	

func save_score(new_score: int): 
	var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE_READ)
	if new_score > highest_score: highest_score = new_score
	file.store_32(highest_score) 


func load_score(): 
	var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
	if FileAccess.file_exists(SAVE_FILE):
		highest_score = file.get_32()
