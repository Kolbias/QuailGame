extends Node2D


@onready var score = PlayerVariables.quail_count
@onready var score_text = $Control/QuailScore

func _ready():
	score_text.text = "You rescued " + str(score) + " quails!"


func _on_quit_button_down():
	get_tree().quit()


func _on_next_button_down():
	PlayerVariables.quail_count = 0
	get_tree().change_scene_to_file("res://world.tscn")
