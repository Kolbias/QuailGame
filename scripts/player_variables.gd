extends Node

var speed := 70.0
var boost_speed := 120.0
var quail_count := 0
var boost_cooldown := 0.0

var quail_total := 0

var quail_collected := 0
var current_level = ["world1", "world2", "world3", "world4", "world4", "world5", "world6", "world7", "world8", "world9"]


func _ready():
	current_level = current_level[0]
	print(current_level)

func _process(delta):
	if quail_count < 0:
		quail_count = 0
