extends CanvasLayer

@onready var quail_count_ui = %QuailCount
@onready var quail_required = %QuailRequired
@onready var timer_ui = %Timer
@onready var time_left = PlayerVariables.time_remaining
@onready var transition = $UI/BlackTransition
@onready var paused_label: Label = %PausedLabel

# Paused Variables
@onready var paused = false
@onready var unpause_button = %UnpauseButton
@onready var pause_quit_button = %PauseQuitButton
@onready var pause_retry = %PauseRetry
@onready var game_over_ui = %GameOverCont
@onready var boost_cooldown_bar = $UI/Control/VBoxContainer3/BoostCooldownBar
@onready var controls_button = %ControlsButton
func _ready():
	#timer.start()
	GlobalSignals.connect("restart_level", _on_restart_level)
	GlobalSignals.connect("restart_level_stop", _on_restart_level_stop)
	GlobalSignals.connect("egg_hatched", _on_egg_hatched)
	GlobalSignals.game_over.connect(_on_game_over)
	unpause_button.connect('button_down', _on_unpause_button_down)
	pause_quit_button.connect("button_down", _on_pause_quit_button_down)
	pause_retry.connect("button_down", _on_pause_retry_button_down)
	#timer.connect("timeout", _on_timer_timeout)
	paused_label.visible = false
	paused = false
	unpause_button.visible = false
	pause_quit_button.visible = false
	pause_retry.visible = false
	game_over_ui.visible = false
	controls_button.visible = false

func _process(delta):
	%RestartBar.value = %RestartTimer.time_left
	quail_count_ui.text = str(PlayerVariables.quail_count)
	#var time_left_rounded = int(timer.time_left)
	timer_ui.text = str(int(PlayerVariables.time_remaining))
	boost_cooldown_bar.value = PlayerVariables.boost_cooldown
	if Input.is_action_just_pressed("pause") and paused == false:
		print("Paused via UI Node")
		paused_label.visible = true
		unpause_button.visible = true
		pause_retry.visible = true
		pause_quit_button.visible = true
		controls_button.visible = true
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
	controls_button.visible = false
	paused_label.visible = false
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


func _on_pause_quit_button_button_down() -> void:
	PlayerVariables.quail_count = 0

func _on_egg_hatched():
	%"2Secs".show()
	var tween = get_tree().create_tween()
	tween.tween_property(%"2Secs", "modulate", Color(1,1,1,0), 2.0).set_trans(Tween.TRANS_LINEAR)
	await tween.finished
	%"2Secs".hide()
	%"2Secs".modulate = Color(1,1,1,1)
	pass
	
func _on_restart_level():
	%RestartTimer.start()
	%RestartContainer.show()
func _on_restart_level_stop():
	%RestartTimer.stop()
	%RestartContainer.hide()


func _on_controls_button_pressed() -> void:
	%HowToPlayVbox.show()
	%BackButton.grab_focus()

func _on_back_button_pressed() -> void:
	%HowToPlayVbox.hide()
	%UnpauseButton.grab_focus()
