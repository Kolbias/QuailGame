extends Node2D

@onready var main_quail = $MainQuail
@onready var baby_quail_left = $BabyQuailLeft
@onready var parallax = %ParallaxBackground
@export var background_scroll_speed = Vector2(0.5,0.5)
@onready var sound = $AudioStreamPlayer2D
@onready var play_button = $CanvasLayer/Control/VBoxContainer/PlayButton

func _ready():
	PlayerVariables.current_level = 1
	
	play_button.grab_focus()
	get_tree().paused = false
	baby_quail_left.flip_h = true
	sound.play()
	
func _process(delta):
	#parallax.motion_offset += background_scroll_speed
	
	#Attempted to animate main quail replace with tweens?
	main_quail.position.x += 500.0 * delta
	if main_quail.position.x > 4000.0:
		main_quail.position = Vector2(53,1039)
	else:
		pass
	#await get_tree().create_timer(1000).timeout
	#main_quail.position.x = 0.0
	#baby_quail_left.flip_h = true
	#await get_tree().create_timer(1000).timeout
	#baby_quail_left.flip_h = false
	#if Input.is_action_pressed("move_down"):
		#pass


func _on_button_button_down():
	get_tree().change_scene_to_file(str("res://world1.tscn").to_lower())


func _on_button_2_button_down():
	get_tree().quit()


func _on_level_select_button_button_down():
	get_tree().change_scene_to_file("res://level_select.tscn")
