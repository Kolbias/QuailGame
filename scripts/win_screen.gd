extends Node2D


@onready var score = PlayerVariables.quail_count
@onready var score_text = $Control/VBoxContainer/QuailScore
@onready var parallax = $ParallaxBackground/ParallaxLayer
@export var background_scroll_speed = Vector2(0.15,0.15)
# Awards
@onready var bronze_star = $Control/BronzeStar
@onready var silver_star = $Control/SilverStar
@onready var gold_star = $Control/GoldStar
@onready var star_text = $Control/VBoxContainer/StarText
@onready var star_speed = 0.5
@onready var star_scale = Vector2(3,3)

# Sounds
@onready var quail_call_sound = $QuailCallSound
@onready var ambient_sound = $Ambience

func _ready():
	var world = PlayerVariables.current_level
	
	# World1 Score Thresholds
	# Bronze
	if score == 10 and world == "world1":
		award_bronze()
	if (score > 10 and score < 20 and world == "world1"):
		award_silver()
	if score >= 20 and world == "world1":
		award_gold()
	
	# World2 Score Thresholds
	if score == 15 and world == "world2":
		award_bronze()
	if (score > 15 and score < 20 and world == "world2"):
		award_silver()
	if score >= 20 and world == "world2":
		award_gold()
	
	# World3 Score Thresholds
	if score == 18 and world == "world3":
		award_bronze()
	if (score > 18 and score < 22 and world == "world3"):
		award_silver()
	if score >= 23 and world == "world3":
		award_gold()

	# World4 Score Thresholds
	if score == 12 and world == "world4":
		award_bronze()
	if (score > 15 and score < 19 and world == "world4"):
		award_silver()
	if score >= 20 and world == "world4":
		award_gold()
		
		
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
		PlayerVariables.current_level = 'world3' 
		print(PlayerVariables.current_level)
		get_tree().change_scene_to_file("res://world3.tscn")
	elif PlayerVariables.current_level == 'world3':
		PlayerVariables.current_level = 'world4' 
		print(PlayerVariables.current_level)
		get_tree().change_scene_to_file("res://world4.tscn")
		
	else:
		get_tree().change_scene_to_file("res://main_menu.tscn")


func award_bronze():
		var tween = get_tree().create_tween()
		bronze_star.visible = true
		tween.tween_property(bronze_star, "scale", star_scale, star_speed)
		star_text.visible = true
		star_text.text = "You got a Bronze Award!"

func award_silver():
		var tween = get_tree().create_tween()
		silver_star.visible = true
		tween.tween_property(silver_star, "scale", star_scale, star_speed)
		star_text.visible = true
		star_text.text = "You got a Silver Award!"
		
func award_gold():
		var tween = get_tree().create_tween()
		gold_star.visible = true
		tween.tween_property(gold_star, "scale", star_scale, star_speed)
		star_text.visible = true
		star_text.text = "You got a Gold Award!"
