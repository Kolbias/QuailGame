extends Node2D

@onready var score = PlayerVariables.quail_count
@onready var score_text = %QuailScore
@onready var parallax = $ParallaxBackground/ParallaxLayer
@export var background_scroll_speed = Vector2(0.15,0.15)

# Awards
@onready var bronze_star = %BronzeStar
@onready var silver_star = %SilverStar
@onready var gold_star = %GoldStar
@onready var star_text = %StarText
@onready var star_speed = 1.2
@onready var star_scale = Vector2(8,8)

@onready var cr1 = PlayerVariables.chall_rating1
@onready var cr2 = PlayerVariables.chall_rating2
@onready var cr3 = PlayerVariables.chall_rating3
@onready var cr4 = PlayerVariables.chall_rating4
@onready var cr5 = PlayerVariables.chall_rating5

# Sounds
@onready var quail_call_sound = $QuailCallSound
@onready var ambient_sound = $Ambience

func _ready():
	GlobalSignals.emit_signal("save_game")
	%Next.grab_focus()
	var world = PlayerVariables.current_level
	
	# World1 Score Thresholds
	# Bronze
	if score == cr1 and world == 1:
		award_bronze()
	elif score == cr1 + 5 and world == 1:
		award_silver()
	elif score == cr1 + 8 and world == 1:
		award_gold()
	
	# World2 Score Thresholds
	if score == cr2 and world == 2:
		award_bronze()
	if (score > cr2 and score < 17 and world == 2):
		award_silver()
	if score >= 17 and world == 2:
		award_gold()
	
	# World3 Score Thresholds
	if score == cr3 and world == 3:
		award_bronze()
	if (score > cr3 and score < 19 and world == 3):
		award_silver()
	if score >= 19 and world == 3:
		award_gold()

	# World4 Score Thresholds
	if score == cr3 and world == 4:
		award_bronze()
	if (score > cr3 and score < 17 and world == 4):
		award_silver()
	if score >= 17 and world == 4:
		award_gold()
	
	# World5
	if score == cr3 and world == 5:
		award_bronze()
	if (score > cr3 and score < 19 and world == 5):
		award_silver()
	if score >= 19 and world == 5:
		award_gold()
	
	# World6
	if score == cr3 and world == 6:
		award_bronze()
	if (score > cr3 and score < 18 and world == 6):
		award_silver()
	if score >= 18 and world == 6:
		award_gold()
	
	# World7
	if score == cr3 and world == 7:
		award_bronze()
	if (score > cr3 and score < 18 and world == 7):
		award_silver()
	if score >= 18 and world == 7:
		award_gold()
	
	# World8
	if score == cr4 and world == 8:
		award_bronze()
	if (score > cr4 and score < 18 and world == 8):
		award_silver()
	if score >= 18 and world == 8:
		award_gold()
	
	# World 9
	if score == cr4 and world == 9:
		award_bronze()
	if (score > cr4 and score < 18 and world == 9):
		award_silver()
	if score >= 18 and world == 9:
		award_gold()
	
	# World 10
	if score == cr4 and world == 10:
		award_bronze()
	if (score > cr4 and score < 18 and world == 10):
		award_silver()
	if score >= 18 and world == 10:
		award_gold()
	
	# World 11
	if score == cr3 and world == 11:
		award_bronze()
	if (score > cr3 and score < 18 and world == 11):
		award_silver()
	if score >= 18 and world == 11:
		award_gold()
		
	# World 12
	if score == cr3 and world == 12:
		award_bronze()
	if (score > cr3 and score < 18 and world == 12):
		award_silver()
	if score >= 18 and world == 12:
		award_gold()
		
	quail_call_sound.play()
	ambient_sound.play()
	score_text.text = "You rescued " + str(score) + " quail!"
	
func _process(delta):
	%EggBackdrop.rotation += 0.001
	%EggBackdrop2.rotation -= 0.001
	parallax.motion_offset += background_scroll_speed

func _on_quit_button_down():
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_next_button_down():
	PlayerVariables.quail_count = 0
	var world = PlayerVariables.current_level
	print(world)
	var next_world = world + 1
	var next_world_path = "res://world" + str(next_world) + ".tscn"
	print("Next world will be: " + str(world))
	PlayerVariables.current_level += 1
	GlobalSignals.emit_signal("exit_win_screen", next_world_path)
	#get_tree().change_scene_to_file(next_world_path)


func award_bronze():
		var tween = get_tree().create_tween()
		bronze_star.visible = true
		tween.tween_property(bronze_star, "scale", star_scale, star_speed).set_trans(Tween.TRANS_ELASTIC)
		star_text.visible = true
		star_text.text = "You got a Bronze Award!"

func award_silver():
		var tween = get_tree().create_tween()
		silver_star.visible = true
		tween.tween_property(silver_star, "scale", star_scale, star_speed).set_trans(Tween.TRANS_ELASTIC)
		star_text.visible = true
		star_text.text = "You got a Silver Award!"
		
func award_gold():
		var tween = get_tree().create_tween()
		gold_star.visible = true
		tween.tween_property(gold_star, "scale", star_scale, star_speed).set_trans(Tween.TRANS_ELASTIC)
		star_text.visible = true
		star_text.text = "You got a Gold Award!"

func set_award(current_score: int):
	var player_score = PlayerVariables.world_1_highscore
	if current_score > player_score:
		player_score = current_score
		print_rich("New Highscore! on world: " + str(PlayerVariables.current_level) + str(player_score))
		
