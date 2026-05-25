extends Node


func get_random_height_on_screen(screen_height: float, objects_height: float, offset: float = 0):
	return randf_range(0+(objects_height/2 + offset), screen_height-(objects_height/2) - offset)
 
