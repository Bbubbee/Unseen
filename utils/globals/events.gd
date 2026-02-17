extends Node

var current_reality: bool = true

func _ready() -> void:
	print('eevents!')

signal players_health_changed(change: int)
signal screen_shake
signal change_realities(reality: bool)
