extends Node2D


var page = 1

func _ready() -> void:
	%World1HighScore.text = "[center]" + str(PlayerVariables.world_1_hs)
	%World2HighScore.text = "[center]" + str(PlayerVariables.world_2_hs)
	%World3HighScore.text = "[center]" + str(PlayerVariables.world_3_hs)

func _process(delta: float) -> void:
	if page == 1:
		%PrevWorld.hide()
		%NextWorld.show()
		%"World1-3".show()
		%"World4-6".hide()
		%"World7-9".hide()
		%"World10-12".hide()
		%"World13-15".hide()

	if page == 2:
		%PrevWorld.show()
		%NextWorld.show()
		%"World1-3".hide()
		%"World4-6".show()
		%"World7-9".hide()
		%"World10-12".hide()
		%"World13-15".hide()

	if page == 3:
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
