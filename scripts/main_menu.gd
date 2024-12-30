extends Node2D

@onready var main_quail = %MainQuail
#@onready var baby_quail_left = %BabyQuailLeft
#@onready var parallax = %ParallaxBackground
@export var background_scroll_speed = Vector2(0.5,0.5)
@onready var sound = %AudioStreamPlayer2D
@onready var play_button = %PlayButton
var current_background = "day"
var tween: Tween

func _ready():
	%DayNightChangeTimer.connect("timeout", _on_day_night_change)
	tween = create_tween()
	tween.tween_property(%PlayButton, "position", Vector2(1000,0), 0)
	tween.tween_property(%SettingsButton, "position", Vector2(1000,0), 0)
	tween.tween_property(%LevelSelectButton, "position", Vector2(1000,0), 0)
	tween.tween_property(%QuitButton, "position", Vector2(1000,0), 0)
	tween.tween_property(%ExtrasButton, "position", Vector2(1000,0), 0)
	tween.tween_property(%Sun, "position", Vector2(1293,1300), 0)
	tween.tween_property(%Moon, "position", Vector2(1293,1300), 0)
	%Logo.pivot_offset = Vector2(125,40)
	#%MainMenuVBox.scale = Vector2(0.1,0.1)
	%MainMenuVBox.modulate = Color(1,1,1,0)
	#%PlayButton.position = Vector2(1000,0)
	#%PlayButton.modulate = Color(1,1,1,0)

	tween.tween_interval(0.2)
	
	#tween.tween_property(%MainMenuVBox, "ssscale", Vector2(2,2), 1.2).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(%MainMenuVBox, "modulate", Color(1,1,1,1), 0.7)
	tween.tween_property(%PlayButton, "position", Vector2(0,20), 1.2).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(%SettingsButton, "position", Vector2(0,80), 1.3).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(%LevelSelectButton, "position", Vector2(0,120), 1.4).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(%ExtrasButton, "position", Vector2(0,160), 1.5).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(%QuitButton, "position", Vector2(0,200), 1.6).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(%Sun, "position", Vector2(1293,648), 2.5).set_trans(Tween.TRANS_ELASTIC)
	
	#tween.parallel().tween_property(%Logo, "rotation", 0.2, 5).set_trans(Tween.TRANS_SINE)
	#await tween.finished
	#tween.tween_property(%Logo, "rotation", -0.2, 5).set_trans(Tween.TRANS_BOUNCE)

	#tween.parallel().tween_property(%PlayButton, "modulate", Color(1,1,1,1), 0.7)
	PlayerVariables.current_level = 1
	#%MainMenuVBox.position.x = 500

	play_button.grab_focus()
	get_tree().paused = false
#	baby_quail_left.flip_h = true
	sound.play()

func _process(delta):
	
	main_quail.position.x += 500.0 * delta
	if main_quail.position.x > 4000.0:
		main_quail.position = Vector2(-100,1015)
	else:
		pass



#func _on_button_button_down():
	#get_tree().change_scene_to_file(str("res://world1.tscn").to_lower())


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
func _on_day_night_change():
	#print("Day/Night Time out")
	var tween = create_tween()
	if current_background == "day":
		tween.tween_property(%SkyDay,"modulate", Color(1,1,1,0), 0.5)
		tween.parallel().tween_property(%Sun, "position", Vector2(1293,1300), 0.5)
		tween.parallel().tween_property(%Moon, "position", Vector2(1425,500), 2.5).set_trans(Tween.TRANS_ELASTIC)
		tween.parallel().tween_property(%CanvasModulate, "color", Color.GRAY, 0.4)
		tween.parallel().tween_property(%SkyNight, "modulate", Color(1,1,1,1), 0.4)
		tween.parallel().tween_property(%Moonlight, "energy", 1, 2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
		tween.parallel().tween_property(%Nightlights, "modulate", Color(1,1,1,1), 0.4)
		current_background = "night"
	elif current_background == "night":
		tween.tween_property(%SkyDay,"modulate", Color(1,1,1,1), 0.5)
		tween.parallel().tween_property(%Moonlight, "energy", 0, 0).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
		tween.parallel().tween_property(%Moon, "position", Vector2(1293,1300), 1.5).set_trans(Tween.TRANS_ELASTIC)
		tween.parallel().tween_property(%Sun, "position", Vector2(1293,648), 2.5).set_trans(Tween.TRANS_ELASTIC)
		tween.parallel().tween_property(%CanvasModulate, "color", Color.WHITE, 0.4)
		tween.parallel().tween_property(%SkyNight, "modulate", Color(1,1,1,0), 0.4)
		tween.parallel().tween_property(%Nightlights, "modulate", Color(1,1,1,0), 0.4)
		current_background = "day"
