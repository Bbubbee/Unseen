extends Label


func init(msg: String): 
	text = msg 

func destroy(): 
	dissolve_in = false
	await get_tree().create_timer(3).timeout
	queue_free()
	
var dissolve: ShaderMaterial
var dissolve_in: bool = true

func _ready() -> void:
	dissolve = material
	
	dissolve.set('shader_parameter/value', 0)

var dissolve_status: float = 0.0
var dissolve_rate: float = 1.5

func _process(delta: float) -> void:
	if dissolve_in: 
		dissolve_status = clamp(dissolve_status+delta/dissolve_rate, 0, 1.0)
		dissolve.set('shader_parameter/value', dissolve_status)
	else: 
		dissolve_status = clamp(dissolve_status-delta/dissolve_rate, 0, 1.0)
		dissolve.set('shader_parameter/value', dissolve_status)
