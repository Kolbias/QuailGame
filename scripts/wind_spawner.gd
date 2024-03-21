extends Node2D

@onready var wind = preload("res://objects/wind_animation.tscn")
@onready var timer = $Timer
@export var time_min = 3
@export var time_max = 5
@onready var random_time = randi_range(time_min, time_max)
@onready var active = false
@onready var random_y_pos = 0.0
@onready var parent = get_parent()

func _ready():
	timer.start()

func _process(delta):
	if position.y > 500:
		position.y = 0
		get_new_y()
	if position.y < -500:
		position.y = 0
		get_new_y()

func _on_timer_timeout():
	spawn_wind()
	get_new_y()
	move()

func spawn_wind():
	var instance = wind.instantiate()
	add_child(instance)
	# print("Debug: Wind Spawned")
	timer.wait_time = random_time
	timer.start()
	# print("Debug: Timer restarted")

func move():
	position.y = random_y_pos
	
func get_new_y():
	random_y_pos += randf_range(-200,200)
	
