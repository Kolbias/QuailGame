extends Area2D
@export var fire_speed = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	print_rich("[color=RED][pulse]Incoming Fire![/pulse]")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += fire_speed
