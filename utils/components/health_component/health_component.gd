extends Node2D

@export var max_health: int = 3
@onready var current_health = max_health

signal died 


# NOTE: Not decoupled. (Event) 

func change_health(change: int):
	current_health = clampi(current_health+change, 0, max_health)
	
	Events.players_health_changed.emit(current_health) 
	
	if current_health <= 0: 
		died.emit()
