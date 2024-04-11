extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_world_1_button_down():
	PlayerVariables.current_level = "world1"
	get_tree().change_scene_to_file("res://world1.tscn")

func _on_button_world_2_button_down():
	PlayerVariables.current_level = "world2"
	get_tree().change_scene_to_file("res://world2.tscn")

func _on_button_world_3_button_down():
	PlayerVariables.current_level = "world3"
	get_tree().change_scene_to_file("res://world3.tscn")

func _on_button_world_4_button_down():
	PlayerVariables.current_level = "world4"
	get_tree().change_scene_to_file("res://world4.tscn")

func _on_button_world_5_button_down():
	PlayerVariables.current_level = "world5"
	get_tree().change_scene_to_file("res://world5.tscn")

func _on_button_world_6_button_down():
	PlayerVariables.current_level = "world6"
	get_tree().change_scene_to_file("res://world6.tscn")

func _on_button_world_7_button_down():
	PlayerVariables.current_level = "world7"
	get_tree().change_scene_to_file("res://world7.tscn")

func _on_button_world_8_button_down():
	PlayerVariables.current_level = "world8"
	get_tree().change_scene_to_file("res://world8.tscn")

func _on_button_world_9_button_down():
	PlayerVariables.current_level = "world9"
	get_tree().change_scene_to_file("res://world9.tscn")
	
func _on_button_world_10_button_down():
	PlayerVariables.current_level = "world10"
	get_tree().change_scene_to_file("res://world10.tscn")

func _on_button_world_11_button_down():
	PlayerVariables.current_level = "world11"
	get_tree().change_scene_to_file("res://world11.tscn")

func _on_button_world_12_button_down():
	PlayerVariables.current_level = "world12"
	get_tree().change_scene_to_file("res://world12.tscn")

func _on_back_button_down():
	get_tree().change_scene_to_file("res://main_menu.tscn")







