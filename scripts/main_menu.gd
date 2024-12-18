extends Node2D

@onready var main_quail = %MainQuail
@onready var baby_quail_left = %BabyQuailLeft
#@onready var parallax = %ParallaxBackground
@export var background_scroll_speed = Vector2(0.5,0.5)
@onready var sound = %AudioStreamPlayer2D
@onready var play_button = %PlayButton

var tween: Tween

func _ready():
	tween = create_tween()
	tween.tween_property(%PlayButton, "position", Vector2(1000,0), 0)
	tween.tween_property(%SettingsButton, "position", Vector2(1000,0), 0)
	tween.tween_property(%LevelSelectButton, "position", Vector2(1000,0), 0)
	tween.tween_property(%QuitButton, "position", Vector2(1000,0), 0)
	#%MainMenuVBox.scale = Vector2(0.1,0.1)
	%MainMenuVBox.modulate = Color(1,1,1,0)
	#%PlayButton.position = Vector2(1000,0)
	#%PlayButton.modulate = Color(1,1,1,0)

	tween.tween_interval(0.2)
	
	#tween.tween_property(%MainMenuVBox, "scale", Vector2(2,2), 1.2).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(%MainMenuVBox, "modulate", Color(1,1,1,1), 0.7)
	tween.tween_property(%PlayButton, "position", Vector2(0,0), 1.2).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(%SettingsButton, "position", Vector2(0,40), 1.3).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(%LevelSelectButton, "position", Vector2(0,80), 1.4).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(%QuitButton, "position", Vector2(0,120), 1.5).set_trans(Tween.TRANS_ELASTIC)
	#tween.parallel().tween_property(%PlayButton, "modulate", Color(1,1,1,1), 0.7)
	PlayerVariables.current_level = 1
	#%MainMenuVBox.position.x = 500

	play_button.grab_focus()
	get_tree().paused = false
	baby_quail_left.flip_h = true
	sound.play()

func _process(delta):

	main_quail.position.x += 500.0 * delta
	if main_quail.position.x > 4000.0:
		main_quail.position = Vector2(53,1039)
	else:
		pass



func _on_button_button_down():
	get_tree().change_scene_to_file(str("res://world1.tscn").to_lower())


func _on_button_2_button_down():
	get_tree().quit()


func _on_level_select_button_button_down():
	get_tree().change_scene_to_file("res://level_select.tscn")


func _on_play_button_button_down() -> void:
	pass # Replace with function body.


func _on_level_select_button_pressed() -> void:
	var level_select_scene = load("res://world_select.tscn")
	GlobalSignals.emit_signal("load_world",level_select_scene)

#func _animate():
	#var tween = get_tree().create_tween()
	#tween.tween_property(%MainMenuVBox, "position.x", 500, 2.2)
