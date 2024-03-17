extends Node2D


@onready var score = PlayerVariables.quail_count
@onready var score_text = $Control/QuailScore
@onready var parallax = $ParallaxBackground/ParallaxLayer
@export var background_scroll_speed = Vector2(0.15,0.15)

func _ready():
	score_text.text = "You rescued " + str(score) + " quails!"
func _process(delta):
	parallax.motion_offset += background_scroll_speed

func _on_quit_button_down():
	get_tree().quit()


func _on_next_button_down():
	PlayerVariables.quail_count = 0
	get_tree().change_scene_to_file("res://world.tscn")
