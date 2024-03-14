extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += 5.0
	if position.y > 1000.0:
		queue_free()
		print("Car culled")
	elif position.y < -1000.0:
		queue_free()
		print("Car culled")
	else:
		pass
