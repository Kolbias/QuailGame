extends StaticBody2D

@onready var timer = $Timer
@onready var sprite = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.

func _ready():
	get_random_time()
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	sprite.play("open")
	get_random_time()
	timer.start()

func get_random_time():
	var new_time = randi_range(20,80)
	timer.wait_time = new_time


func _on_animated_sprite_2d_animation_finished():
	get_random_time()
	#print(timer.wait_time)
	timer.start()
