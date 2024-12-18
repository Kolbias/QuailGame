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
	if world == 1:
		if check_highscore(score, PlayerVariables.world_1_hs):
			PlayerVariables.world_1_hs = score
			GlobalSignals.emit_signal("save_game")
		if score == cr1:
			award_bronze()
		if score > cr1 and score < 15:
			award_silver()
		if score >= 15:
			award_gold()
	
	# World2 Score Thresholds
	if world == 2: 
		if check_highscore(score, PlayerVariables.world_2_hs):
			PlayerVariables.world_2_hs = score
			GlobalSignals.emit_signal("save_game")
		if score == cr2:
			award_bronze()
		if score > cr2 and score < 17:
			award_silver()
		if score >= 17:
			award_gold()
	
	# World3 Score Thresholds
	if world == 3:
		if check_highscore(score, PlayerVariables.world_3_hs):
			PlayerVariables.world_3_hs = score
			GlobalSignals.emit_signal("save_game")
		if score == cr3:
			award_bronze()
		if score > cr3 and score < 19:
			award_silver()
		if score >= 19:
			award_gold()

	# World4 Score Thresholds
	if world == 4:
		if check_highscore(score, PlayerVariables.world_4_hs):
			PlayerVariables.world_4_hs = score
			GlobalSignals.emit_signal("save_game")
		if score == cr3:
			award_bronze()
		if score > cr3 and score < 17:
			award_silver()
		if score >= 17:
			award_gold()
	
	# World5
	if world == 5:
		if check_highscore(score, PlayerVariables.world_5_hs):
			PlayerVariables.world_5_hs = score
			GlobalSignals.emit_signal("save_game")
		if score == cr3:
			award_bronze()
		if score > cr3 and score < 19:
			award_silver()
		if score >= 19:
			award_gold()
	
	# World6
	if world == 6:
		if check_highscore(score, PlayerVariables.world_6_hs):
			PlayerVariables.world_6_hs = score
			GlobalSignals.emit_signal("save_game")
		if score == cr3:
			award_bronze()
		if score > cr3 and score < 18:
			award_silver()
		if score >= 18:
			award_gold()
	
	# World7
	if world == 7:
		if check_highscore(score, PlayerVariables.world_7_hs):
			PlayerVariables.world_7_hs = score
			GlobalSignals.emit_signal("save_game")
		if score == cr3:
			award_bronze()
		if score > cr3 and score < 18:
			award_silver()
		if score >= 18:
			award_gold()
	
	# World8
	if world == 8:
		if check_highscore(score, PlayerVariables.world_8_hs):
			PlayerVariables.world_8_hs = score
			GlobalSignals.emit_signal("save_game")
		if score == cr4 and world == 8:
			award_bronze()
		if (score > cr4 and score < 18 and world == 8):
			award_silver()
		if score >= 18 and world == 8:
			award_gold()
	
	# World 9
	if world == 9:
		if check_highscore(score, PlayerVariables.world_9_hs):
			PlayerVariables.world_9_hs = score
			GlobalSignals.emit_signal("save_game")
			if score == cr4:
				award_bronze()
			if score > cr4 and score < 18:
				award_silver()
			if score >= 18:
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
	GlobalSignals.emit_signal("save_game")
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

func check_highscore(current_score: int, player_world_score):
	if current_score > player_world_score:
		player_world_score = current_score
		print_rich("New Highscore! on world" + str(PlayerVariables.current_level) + " = " + str(player_world_score))
		return true
