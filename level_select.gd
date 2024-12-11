extends Node2D

func _ready():
	%ButtonWorld1.grab_focus()

func _on_button_world_1_button_down():
	PlayerVariables.current_level = 1
	get_parent().change_scene_to_file("res://world1.tscn")

func _on_button_world_2_button_down():
	PlayerVariables.current_level = 2
	get_tree().change_scene_to_file("res://world2.tscn")

func _on_button_world_3_button_down():
	PlayerVariables.current_level = 3
	get_tree().change_scene_to_file("res://world3.tscn")

func _on_button_world_4_button_down():
	PlayerVariables.current_level = 4
	get_tree().change_scene_to_file("res://world4.tscn")

func _on_button_world_5_button_down():
	PlayerVariables.current_level = 5
	get_tree().change_scene_to_file("res://world5.tscn")

func _on_button_world_6_button_down():
	PlayerVariables.current_level = 6
	get_tree().change_scene_to_file("res://world6.tscn")

func _on_button_world_7_button_down():
	PlayerVariables.current_level = 7
	get_tree().change_scene_to_file("res://world7.tscn")

func _on_button_world_8_button_down():
	PlayerVariables.current_level = 8
	get_tree().change_scene_to_file("res://world8.tscn")

func _on_button_world_9_button_down():
	PlayerVariables.current_level = 9
	get_tree().change_scene_to_file("res://world9.tscn")
	
func _on_button_world_10_button_down():
	PlayerVariables.current_level = 10
	get_tree().change_scene_to_file("res://world10.tscn")

func _on_button_world_11_button_down():
	PlayerVariables.current_level = 11
	get_tree().change_scene_to_file("res://world11.tscn")

func _on_button_world_12_button_down():
	PlayerVariables.current_level = 12
	get_tree().change_scene_to_file("res://world12.tscn")

func _on_back_button_down():
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_button_world_13_button_down() -> void:
	pass # Replace with function body.
