extends ParallaxBackground

@export var background_scroll_speed = Vector2(0.05,0.05)
@onready var parallax = $ParallaxLayer
@onready var second_parallax = $ParallaxLayer3
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	parallax.motion_offset += background_scroll_speed
	second_parallax.motion_offset += background_scroll_speed
