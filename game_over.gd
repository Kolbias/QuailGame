extends Node2D
@onready var parallax = $ParallaxBackground/ParallaxLayer
@export var background_scroll_speed = Vector2(0.15,0.15)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	parallax.motion_offset += background_scroll_speed


func _on_play_again_button_down():
	PlayerVariables.quail_count = 0
	get_tree().change_scene_to_file("res://world.tscn")


func _on_quit_button_down():
	
	get_tree().quit()
