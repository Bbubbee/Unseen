extends Node

@onready var current_reality: bool = [true, false].pick_random()

signal players_health_changed(change: int)
signal screen_shake
signal change_realities()
