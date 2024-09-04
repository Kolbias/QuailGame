extends CanvasLayer

@onready var quail_count_ui = %QuailCount
@onready var quail_required = %QuailRequired
@onready var timer_ui = $UI/Control/VBoxContainer3/Timer
@onready var time_left = PlayerVariables.time_remaining
@onready var transition = $UI/BlackTransition

# Paused Variables
@onready var paused = false
@onready var unpause_button = $UI/Control/VBoxContainer/UnpauseButton
@onready var pause_quit_button = $UI/Control/VBoxContainer/PauseQuitButton
@onready var pause_retry = $UI/Control/VBoxContainer/PauseRetry
@onready var game_over_ui = %GameOverCont
@onready var boost_cooldown_bar = $UI/Control/VBoxContainer3/BoostCooldownBar

func _ready():
	#timer.start()
	GlobalSignals.game_over.connect(_on_game_over)
	unpause_button.connect('button_down', _on_unpause_button_down)
	pause_quit_button.connect("button_down", _on_pause_quit_button_down)
	pause_retry.connect("button_down", _on_pause_retry_button_down)
	#timer.connect("timeout", _on_timer_timeout)
	
	paused = false
	unpause_button.visible = false
	pause_quit_button.visible = false
	pause_retry.visible = false
	game_over_ui.visible = false

func _process(delta):
	quail_count_ui.text = "Quail Count: " + str(PlayerVariables.quail_count)
	#var time_left_rounded = int(timer.time_left)
	timer_ui.text = "Time Left: " + str(int(PlayerVariables.time_remaining))
	boost_cooldown_bar.value = PlayerVariables.boost_cooldown
	if Input.is_action_just_pressed("pause") and paused == false:
		print("Paused via UI Node")
		unpause_button.visible = true
		pause_retry.visible = true
		pause_quit_button.visible = true
		get_tree().paused = true
		unpause_button.grab_focus()
		
	if PlayerVariables.current_level == 1:
		quail_required.text = str(PlayerVariables.chall_rating1)
	if PlayerVariables.current_level == 2:
		quail_required.text = str(PlayerVariables.chall_rating2)
	if PlayerVariables.current_level == 3:
		quail_required.text = str(PlayerVariables.chall_rating3)
	if PlayerVariables.current_level == 4:
		quail_required.text = str(PlayerVariables.chall_rating3)
	if PlayerVariables.current_level == 5:
		quail_required.text = str(PlayerVariables.chall_rating3)
	if PlayerVariables.current_level == 6:
		quail_required.text = str(PlayerVariables.chall_rating3)
	if PlayerVariables.current_level == 7:
		quail_required.text = str(PlayerVariables.chall_rating3)
	if PlayerVariables.current_level == 8:
		quail_required.text = str(PlayerVariables.chall_rating4)
	if PlayerVariables.current_level == 9:
		quail_required.text = str(PlayerVariables.chall_rating4)
	if PlayerVariables.current_level == 10:
		quail_required.text = str(PlayerVariables.chall_rating4)
	if PlayerVariables.current_level == 11:
		quail_required.text = str(PlayerVariables.chall_rating3)
	if PlayerVariables.current_level == 12:
		quail_required.text = str(PlayerVariables.chall_rating3)
		
func _on_unpause_button_down():
	unpause_button.visible = false
	pause_retry.visible = false
	pause_quit_button.visible = false
	get_tree().paused = false

func  _on_pause_quit_button_down():
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_pause_retry_button_down():
	PlayerVariables.quail_count = 0
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://game_over.tscn")

func _on_game_over():
	game_over_ui.visible = true
