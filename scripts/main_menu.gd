extends Node2D

@onready var main_quail = $MainQuail
@onready var baby_quail_left = $BabyQuailLeft

func _ready():
	baby_quail_left.flip_h = true
func _process(delta):
	#Attempted to animate main quail replace with tweens?
	#main_quail.position.x += 50.0 * delta
	#await get_tree().create_timer(1000).timeout
	#main_quail.position.x = 0.0
	#baby_quail_left.flip_h = true
	#await get_tree().create_timer(1000).timeout
	#baby_quail_left.flip_h = false
	if Input.is_action_pressed("move_down"):
		get_tree().change_scene_to_file("res://world.tscn")
