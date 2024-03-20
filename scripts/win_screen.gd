extends Node2D


@onready var score = PlayerVariables.quail_count
@onready var score_text = $Control/VBoxContainer/QuailScore
@onready var parallax = $ParallaxBackground/ParallaxLayer
@export var background_scroll_speed = Vector2(0.15,0.15)
@onready var bronze_star = $Control/BronzeStar
@onready var silver_star = $Control/SilverStar
@onready var gold_star = $Control/GoldStar

# Sounds
@onready var quail_call_sound = $QuailCallSound
@onready var ambient_sound = $Ambience

func _ready():
	var tween = get_tree().create_tween()
	var score = PlayerVariables.quail_count
	var world = PlayerVariables.current_level
	
	# World1 Score Thresholds
	if score == 10 and world == "world1":
		bronze_star.visible = true
		tween.tween_property(bronze_star, "scale", Vector2(3,3), 1)
	if (score > 10 and score < 20 and world == "world1"):
		silver_star.visible = true
		tween.tween_property(silver_star, "scale", Vector2(3,3), 1)
	if score > 20 and world == "world1":
		gold_star.visible = true
		tween.tween_property(gold_star, "scale", Vector2(3,3), 1)
	
	# World2 Score Thresholds
	if score == 15 and world == "world2":
		bronze_star.visible = true
		tween.tween_property(bronze_star, "scale", Vector2(3,3), 1)
	if (score > 15 and score < 20 and world == "world2"):
		silver_star.visible = true
		tween.tween_property(silver_star, "scale", Vector2(3,3), 1)
	if score > 20 and world == "world2":
		gold_star.visible = true
		tween.tween_property(gold_star, "scale", Vector2(3,3), 1)
	
	# World3 Score Thresholds
	if score == 18 and world == "world3":
		bronze_star.visible = true
		tween.tween_property(bronze_star, "scale", Vector2(3,3), 1)
	if (score > 18 and score < 22 and world == "world3"):
		silver_star.visible = true
		tween.tween_property(silver_star, "scale", Vector2(3,3), 1)
	if score > 23 and world == "world3":
		gold_star.visible = true
		tween.tween_property(gold_star, "scale", Vector2(3,3), 1)


	quail_call_sound.play()
	ambient_sound.play()
	score_text.text = "You rescued " + str(score) + " quail!"
	
func _process(delta):
	parallax.motion_offset += background_scroll_speed

func _on_quit_button_down():
	get_tree().quit()


func _on_next_button_down():
	PlayerVariables.quail_count = 0
	if PlayerVariables.current_level == 'world1':
		PlayerVariables.current_level = 'world2'
		print(PlayerVariables.current_level)
		get_tree().change_scene_to_file("res://world2.tscn")
	elif PlayerVariables.current_level == 'world2':
		PlayerVariables.current_level = 'world3' #Change to World3 When Created
		print(PlayerVariables.current_level)
		get_tree().change_scene_to_file("res://world3.tscn")
		
	else:
		get_tree().change_scene_to_file("res://main_menu.tscn")
