extends RigidBody2D
class_name Health


func _on_hitbox_area_touched_by_player() -> void:
	queue_free()
