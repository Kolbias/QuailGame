extends Node2D
@onready var parallax = $ParallaxBackground/ParallaxLayer
@export var background_scroll_speed = Vector2(0.15,0.15)
@onready var current_level = PlayerVariables.current_level

func _ready():
	$Control/VBoxContainer/PlayAgain.grab_focus()
func _process(_delta):
	parallax.motion_offset += background_scroll_speed

func _on_play_again_button_down():
	PlayerVariables.quail_count = 0
	var world = PlayerVariables.current_level
	var full_path = "res://world" + str(world) + ".tscn"
	print("World path is: " + full_path)
	get_tree().change_scene_to_file(full_path)

func _on_quit_button_down():
	get_tree().change_scene_to_file("res://main_menu.tscn")
