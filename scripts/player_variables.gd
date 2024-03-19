extends Node

var speed = 2.0
var quail_count = 0

var current_level = "world1"

func _process(delta):
	if quail_count < 0:
		quail_count = 0
