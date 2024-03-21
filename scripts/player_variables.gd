extends Node

var speed = 100.0
var quail_count = 20

var current_level = "world1"

func _process(delta):
	if quail_count < 0:
		quail_count = 0
