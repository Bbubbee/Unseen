extends Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func flash_green(): 
	animation_player.play("flash_green")
	

func flash_red(): 
	animation_player.play("flash_red")
