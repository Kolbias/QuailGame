extends Node

var speed := 100.0
var boost_speed := 165.0
var quail_count := 10
var boost_cooldown := 0.0
var time_remaining := 0
var quail_total := 0

var quail_collected := 0
var current_level = 1

var chall_rating1 := 10
var chall_rating2 := 12
var chall_rating3 := 16
var chall_rating4 := 18
var chall_rating5 := 20

func _ready():
	current_level = current_level
	print(current_level)

func _process(delta):
	if quail_count < 0:
		quail_count = 0
