extends AnimatedSprite2D

@onready var timer = $Timer
@onready var random_time = randi_range(1,10)
@onready var random_speed = randf_range(0.3,0.7)
@onready var random_size_x = randf_range(1, 2)
@onready var random_size_y = randf_range(1, 1.5)
@onready var random_x_pos = randf_range(0, 500)
# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = random_x_pos
	timer.wait_time = random_time
	scale = Vector2(random_size_x, random_size_y)
	#timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += random_speed

#func _on_timer_timeout():
	#play()


func _on_animation_finished():
	queue_free()
	timer.start()
