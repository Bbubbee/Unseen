extends RigidBody2D
class_name Health

@onready var sprite = $Sprite
var tween: Tween
@onready var gpu_particles_2d = $GPUParticles2D
@onready var hitbox_area = $HitboxArea
@onready var increase_health = $IncreaseHealth


func _ready():
	tween = get_tree().create_tween()
	# TODO: Fix this.
	tween.tween_property(sprite, "rotation", 360, 50).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(sprite, "rotation", 0, 50).set_ease(Tween.EASE_IN_OUT)
	
	#tween.set_loops()


func _on_hitbox_area_touched_by_player() -> void:
	increase_health.play()
	hitbox_area.disable()
	tween.stop()
	gpu_particles_2d.emitting = false
	sprite.visible = false
	
	#await gpu_particles_2d.finished  # Doesn't work since one_shot disabled.
	
	await get_tree().create_timer(7).timeout
	
	queue_free()
