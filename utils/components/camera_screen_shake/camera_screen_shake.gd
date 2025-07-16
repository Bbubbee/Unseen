extends Camera2D

# How quickly to move through the noise.
@export var NOISE_SHAKE_SPEED: float = 15
# Noise returns values in the range (-1, 1)
# This is how much to multiply the return value by.
@export var NOISE_SHAKE_STRENGTH: float = 15
# The starting range of possible offsets using random values. 
@export var RANDOM_SHAKE_STRENGTH: float = 15
# Multiplier for lerping the shake strength to zero. 
@export var SHAKE_DECAY_RATE: float = 5

# Keeps track of where we are in the noise. 
# So we can smoothly move through it. 
var noise_i: float = 0
var shake_strength: float = 0
@onready var noise = FastNoiseLite.new()

# noise.frequency = 0.(whatever) # Change noise.period = 2

func _ready():
	# Randomize the generated noise. 
	noise.seed = randi()
	# The frequency a noise changes values. 
	noise.frequency = 0.2
	
	Events.screen_shake.connect(_on_screen_shake)

func _on_screen_shake():
	shake_strength = NOISE_SHAKE_STRENGTH

func _process(delta):
	# Goes from shake_stength to zero at certain rate. 
	shake_strength = lerpf(shake_strength, 0, SHAKE_DECAY_RATE * delta)
	
	# Applies the shake by changing the cameras offset. 
	self.offset = get_noise_offset(delta) 


func get_noise_offset(delta):
	noise_i += delta * NOISE_SHAKE_SPEED 

	return Vector2(
		noise.get_noise_2d(1, noise_i) * shake_strength,
		noise.get_noise_2d(100, noise_i) * shake_strength
	)
