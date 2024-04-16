extends Node2D
@onready var parallax = $ParallaxBackground/ParallaxLayer
@export var background_scroll_speed = Vector2(0.15,0.15)
@onready var current_level = PlayerVariables.current_level


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/VBoxContainer/PlayAgain.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	parallax.motion_offset += background_scroll_speed


func _on_play_again_button_down():
	PlayerVariables.quail_count = 0
	var world = PlayerVariables.current_level
	var full_path = "res://" + world + ".tscn"
	print("World path is: " + full_path)
	get_tree().change_scene_to_file(full_path)
	#if current_level == "world1" or "world":
		#get_tree().change_scene_to_file("res://world.tscn")
	#if current_level == "world2":
		#get_tree().change_scene_to_file("res://world2.tscn")
	#if current_level == "world3":
		#get_tree().change_scene_to_file("res://world3.tscn")
	#if current_level == "world4":
		#get_tree().change_scene_to_file("res://world4.tscn")
	#if current_level == "world5":
		#get_tree().change_scene_to_file("res://world5.tscn")
	#if current_level == "world6":
		#get_tree().change_scene_to_file("res://world6.tscn")
	#if current_level == "world7":
		#get_tree().change_scene_to_file("res://world7.tscn")


func _on_quit_button_down():
	
	get_tree().change_scene_to_file("res://main_menu.tscn")
#
#func get_current_world(new_world):
	#var world = PlayerVariables.current_level
	#new_world = "res://" + world
	#print("World path is: " + new_world)
	#return new_world
