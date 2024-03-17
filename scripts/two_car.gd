extends Area2D
@onready var speed = randf_range(3.0, 8.0)
@onready var car2 = $Area2D
# Called when the node enters the scene tree for the first time.
func _ready():
	car2.position.y -= randf_range(50.0,200.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	drive()
	if position.y > 1000.0:
		queue_free()
		print("Car culled")
	elif position.y < -1000.0:
		queue_free()
		print("Car culled")
	else:
		pass


func drive():
	position.y += speed
