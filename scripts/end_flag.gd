extends Area2D
@onready var timer = $Timer
@onready var eggs_required_ui = $Control/VBoxContainer/Label
@onready var progress_bar = $Control/VBoxContainer/ProgressBar


func _ready():
	# Quail Amount needed for each level UI Text
	progress_bar.visible = false
	if PlayerVariables.current_level == "world1":
		eggs_required_ui.text = "10+ Quail"
	if PlayerVariables.current_level == "world2":
		eggs_required_ui.text = "15+ Quail"
	if PlayerVariables.current_level == "world3":
		eggs_required_ui.text = "18+ Quail"
	if PlayerVariables.current_level == "world4":
		eggs_required_ui.text = "12+ Quail"

func _process(_delta):
	progress_bar.value = timer.time_left

# Quail Amount needed for each level
func _on_area_entered(area):
	if PlayerVariables.current_level == "world1":
		if area.is_in_group("player") and PlayerVariables.quail_count >= 10:
			progress_bar.visible = true
			print("win quail count = " + str(PlayerVariables.quail_count))
			timer.start()
		else:
			print("you have no quails!")
	if PlayerVariables.current_level == "world2":
		if area.is_in_group("player") and PlayerVariables.quail_count >= 15:
			progress_bar.visible = true
			print("win quail count = " + str(PlayerVariables.quail_count))
			timer.start()
		else:
			print("you have no quails!")
	if PlayerVariables.current_level == "world3":
		if area.is_in_group("player") and PlayerVariables.quail_count >= 18:
			progress_bar.visible = true
			print("win quail count = " + str(PlayerVariables.quail_count))
			timer.start()
	if PlayerVariables.current_level == "world4":
		if area.is_in_group("player") and PlayerVariables.quail_count >= 12:
			progress_bar.visible = true
			print("win quail count = " + str(PlayerVariables.quail_count))
			timer.start()
		else:
			print("you have no quails!")
	


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://win_screen.tscn")


func _on_area_exited(area):
	if area.is_in_group("player"):
		progress_bar.visible = false
		timer.stop()
