extends Marker2D


@onready var car = preload("res://semitruck.tscn")
@onready var timer = get_node("Timer")

@export var min_random_time = 4.0
@export var max_random_time = 8.0

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.timeout.connect(_on_timer_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func spawn_truck():
	var truck_spawned := false
	if truck_spawned == false:
		var instance = car.instantiate()
		add_child(instance)
	else:
		pass
		
func _on_timer_timeout():
	spawn_truck()
	var new_time = randf_range(4.0, 8.0)
	timer.start(new_time)
