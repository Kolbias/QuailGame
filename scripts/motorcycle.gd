extends Area2D

@onready var speed = randf_range(3.5, 11.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	get_random_lane_pos()


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

func get_random_lane_pos():
	var random_x = randf_range(-15.0,15.0)
	position.x += random_x
