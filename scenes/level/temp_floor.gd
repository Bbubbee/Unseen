extends RigidBody2D


@onready var warm_tile_map_layer: TileMapLayer = $WarmTileMapLayer
@onready var cool_tile_map_layer: TileMapLayer = $CoolTileMapLayer

func _ready() -> void:
	Events.connect("change_realities", _on_change_reality)

func _process(_delta):
	# Queue free when floor is off the screen. 
	if ((position.x + ($CollisionShape2D.shape.size.x/2))+50) < 0: 
		queue_free()


func _on_change_reality(reality: bool) -> void:
	warm_tile_map_layer.visible = not warm_tile_map_layer.visible
	cool_tile_map_layer.visible = not cool_tile_map_layer.visible
	
