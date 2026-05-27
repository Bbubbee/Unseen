extends RigidBody2D
class_name Health

@onready var sprite = $Sprite
var tween: Tween


func _ready():
	tween = get_tree().create_tween()
	# TODO: Fix this.
	tween.tween_property(sprite, "rotation", 360, 50).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(sprite, "rotation", 0, 50).set_ease(Tween.EASE_IN_OUT)
	
	#tween.set_loops()



func _on_hitbox_area_touched_by_player() -> void:
	tween.stop()
	queue_free()
