extends Area2D
@onready var speed = randf_range(3.0, 8.0)
@onready var car2 = $Area2D
@onready var rand_car_color = randi_range(1,3)
@onready var sprite1 = $CarSprite1
@onready var sprite2 = $Area2D/CarSprite2
# Called when the node enters the scene tree for the first time.
func _ready():
	car2.position.y -= randf_range(50.0,300.0)
	if rand_car_color == 1:
		sprite1.animation = 'white'
		sprite2.animation = 'red'
	elif rand_car_color == 2:
		sprite1.animation = 'blue'
		sprite1.animation = 'white'
	elif rand_car_color == 3:
		sprite1.animation = 'red'
		sprite1.animation = 'blue'


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
