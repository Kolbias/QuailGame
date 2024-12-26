extends Node2D

@onready var current_background = %StripesBackground
var page = 1

func _ready() -> void:
	
	%World1HighScore.text = "[center]" + str(PlayerVariables.world_1_hs)
	%World2HighScore.text = "[center]" + str(PlayerVariables.world_2_hs)
	%World3HighScore.text = "[center]" + str(PlayerVariables.world_3_hs)
	%World4HighScore.text = "[center]" + str(PlayerVariables.world_4_hs)
	%World5HighScore.text = "[center]" + str(PlayerVariables.world_5_hs)
	%World6HighScore.text = "[center]" + str(PlayerVariables.world_6_hs)
	%World7HighScore.text = "[center]" + str(PlayerVariables.world_7_hs)
	%World8HighScore.text = "[center]" + str(PlayerVariables.world_8_hs)
	%World9HighScore.text = "[center]" + str(PlayerVariables.world_9_hs)
	#%World10HighScore.text = "[center]" + str(PlayerVariables.world_10_hs)
	#%World11HighScore.text = "[center]" + str(PlayerVariables.world_11_hs)
	#%World12HighScore.text = "[center]" + str(PlayerVariables.world_12_hs)
	%LoadWorld1Button.grab_focus()
func _process(delta: float) -> void:
	if page == 1:
		if current_background == %StripesBackground:
			%StripesBackground.modulate = Color(1,1,1,1)
		else:
			_fade_background(%NightBackground, %StripesBackground)
		%PrevWorld.hide()
		%NextWorld.show()
		%"World1-3".show()
		%"World4-6".hide()
		%"World7-9".hide()
		%"World10-12".hide()
		%"World13-15".hide()

	if page == 2:
		if current_background == %StripesBackground:
			_fade_background(%StripesBackground, %NightBackground)
		else: 
			_fade_background(%CloudBackground, %NightBackground)
		current_background = %NightBackground
		%PrevWorld.show()
		%NextWorld.show()
		%"World1-3".hide()
		%"World4-6".show()
		%"World7-9".hide()
		%"World10-12".hide()
		%"World13-15".hide()

	if page == 3:
		if current_background == %NightBackground:
			_fade_background(%NightBackground, %CloudBackground)
		else: 
			pass
		current_background = %CloudBackground
		%PrevWorld.show()
		%NextWorld.show()
		%"World1-3".hide()
		%"World4-6".hide()
		%"World7-9".show()
		%"World10-12".hide()
		%"World13-15".hide()
		
	if page == 4:
		%PrevWorld.show()
		%NextWorld.show()
		%"World1-3".hide()
		%"World4-6".hide()
		%"World7-9".hide()
		%"World10-12".show()
		%"World13-15".hide()

	if page == 5:
		%PrevWorld.show()
		%NextWorld.show()
		%"World1-3".hide()
		%"World4-6".hide()
		%"World7-9".hide()
		%"World10-12".hide()
		%"World13-15".show()

func _on_next_world_pressed() -> void:
	page += 1

func _on_prev_world_pressed() -> void:
	page -= 1

func _fade_background(previous, current):
	var p = get_tree().create_tween()
	var c = get_tree().create_tween()
	p.tween_property(previous, "modulate", Color(1,1,1,0), 0.5)
	c.tween_property(current, "modulate", Color(1,1,1,1), 0.5)
