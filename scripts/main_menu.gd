extends Node2D

@onready var main_quail = $MainQuail
@onready var baby_quail_left = $BabyQuailLeft
@onready var parallax = $ParallaxBackground/ParallaxLayer
@export var background_scroll_speed = Vector2(0.5,0.5)
@onready var sound = $AudioStreamPlayer2D

func _ready():
	baby_quail_left.flip_h = true
	sound.play()
	
func _process(delta):
	parallax.motion_offset += background_scroll_speed
	#Attempted to animate main quail replace with tweens?
	main_quail.position.x += 50.0 * delta
	if main_quail.position.x > 200.0:
		main_quail.position = Vector2(-150,40)
	else:
		pass
	#await get_tree().create_timer(1000).timeout
	#main_quail.position.x = 0.0
	#baby_quail_left.flip_h = true
	#await get_tree().create_timer(1000).timeout
	#baby_quail_left.flip_h = false
	if Input.is_action_pressed("move_down"):
		pass


func _on_button_button_down():
	get_tree().change_scene_to_file("res://world.tscn")


func _on_button_2_button_down():
	get_tree().quit()
