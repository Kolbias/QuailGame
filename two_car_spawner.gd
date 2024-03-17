extends Marker2D


@onready var car = preload("res://two_car.tscn")

@onready var timer = get_node("Timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.timeout.connect(_on_timer_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_car():
	var car_spawned := false
	if car_spawned == false:
		var instance = car.instantiate()
		add_child(instance)

	else:
		pass
		
func _on_timer_timeout():
	spawn_car()
	var new_time = randf_range(4.0, 8.0)
	timer.start(new_time)
