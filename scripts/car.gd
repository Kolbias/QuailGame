extends Area2D

@onready var speed = randf_range(3.0, 8.0)
@onready var rand_car_color = randi_range(1,3)
@onready var sprite = $AnimatedSprite2D


func _ready():
	if rand_car_color == 1:
		sprite.animation = 'white'
	elif rand_car_color == 2:
		sprite.animation = 'blue'
	elif rand_car_color == 3:
		sprite.animation = 'red'

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
