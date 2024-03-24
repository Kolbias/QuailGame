extends Area2D

@onready var speed = randf_range(6.0, 12.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	drive()
	if position.y > 1500.0:
		queue_free()
		# print("Debug: Car culled")
	elif position.y < -1500.0:
		queue_free()
		# print("Debug: Car culled")
	else:
		pass


func drive():
	position.y += speed
