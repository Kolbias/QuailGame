extends Node2D

@onready var wind = preload("res://objects/wind_animation.tscn")
@onready var timer = $Timer
@export var time_min = 3
@export var time_max = 20
@onready var random_time = randi_range(time_min, time_max)
@onready var active = false

func _ready():
	spawn_wind()
	
	

func _process(delta):
	pass
		

# None of this works :(
func _on_timer_timeout():
	active = true
	active = false

func spawn_wind():
	while active:
		var instance = wind.instantiate()
		add_child(instance)
		continue
