extends Node2D

@onready var cool_bg_static: ColorRect = $CoolBGStatic
@onready var warm_bg_static: ColorRect = $WarmBGStatic
@onready var cool_bg: Node2D = $CoolBG
@onready var warm_bg: Node2D = $WarmBG


func _ready() -> void:
	Events.connect("change_realities", _on_change_reality)
	
	if Events.current_reality: 
		cool_bg.visible = false
		warm_bg.visible = true	
		cool_bg_static.visible = false
		warm_bg_static.visible = true	
		
	else:
		warm_bg.visible = false
		cool_bg.visible = true
		warm_bg_static.visible = false
		cool_bg_static.visible = true
	
	
func _on_change_reality():
	if Events.current_reality: 
		cool_bg.visible = false
		warm_bg.visible = true	
		cool_bg_static.visible = false
		warm_bg_static.visible = true	
		
	else:
		warm_bg.visible = false
		cool_bg.visible = true
		warm_bg_static.visible = false
		cool_bg_static.visible = true
