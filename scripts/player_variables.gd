extends Node

var speed = 100.0
var quail_count = 0
var quail_total = 0

#var current_level = "world1"
var current_level = ["world1", "world2", "world3", "world4", "world4", "world5", "world6"]
func _ready():
	current_level = current_level[0]
	print(current_level)
func _process(delta):
	if quail_count < 0:
		quail_count = 0
