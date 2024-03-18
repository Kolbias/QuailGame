extends Node2D
@onready var parallax = $ParallaxBackground/ParallaxLayer
@export var background_scroll_speed = Vector2(0.15,0.15)
@onready var current_level = PlayerVariables.current_level
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	parallax.motion_offset += background_scroll_speed


func _on_play_again_button_down():
	PlayerVariables.quail_count = 0
	if current_level == "world1":
		get_tree().change_scene_to_file("res://world.tscn")
	elif current_level == "world2":
		get_tree().change_scene_to_file("res://world2.tscn")
	elif current_level == "world3":
		get_tree().change_scene_to_file("res://world3.tscn")


func _on_quit_button_down():
	
	get_tree().quit()
