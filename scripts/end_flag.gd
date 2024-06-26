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
	if PlayerVariables.current_level == "world5":
		eggs_required_ui.text = "14+ Quail"
	if PlayerVariables.current_level == "world6":
		eggs_required_ui.text = "16+ Quail"
	if PlayerVariables.current_level == "world7":
		eggs_required_ui.text = "18+ Quail"
	if PlayerVariables.current_level == "world8":
		eggs_required_ui.text = "18+ Quail"
	if PlayerVariables.current_level == "world9":
		eggs_required_ui.text = "20+ Quail"
	if PlayerVariables.current_level == "world10":
		eggs_required_ui.text = "20+ Quail"
	if PlayerVariables.current_level == "world11":
		eggs_required_ui.text = "20+ Quail"
	if PlayerVariables.current_level == "world12":
		eggs_required_ui.text = "20+ Quail"
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
	
	if PlayerVariables.current_level == "world5":
		if area.is_in_group("player") and PlayerVariables.quail_count >= 14:
			progress_bar.visible = true
			print("win quail count = " + str(PlayerVariables.quail_count))
			timer.start()
	
	if PlayerVariables.current_level == "world6":
		if area.is_in_group("player") and PlayerVariables.quail_count >= 16:
			progress_bar.visible = true
			print("win quail count = " + str(PlayerVariables.quail_count))
			timer.start()
			
	if PlayerVariables.current_level == "world7":
		if area.is_in_group("player") and PlayerVariables.quail_count >= 18:
			progress_bar.visible = true
			print("win quail count = " + str(PlayerVariables.quail_count))
			timer.start()
			
	if PlayerVariables.current_level == "world8":
		if area.is_in_group("player") and PlayerVariables.quail_count >= 18:
			progress_bar.visible = true
			print("win quail count = " + str(PlayerVariables.quail_count))
			timer.start()
			
	if PlayerVariables.current_level == "world9":
		if area.is_in_group("player") and PlayerVariables.quail_count >= 20:
			progress_bar.visible = true
			print("win quail count = " + str(PlayerVariables.quail_count))
			timer.start()
			
	if PlayerVariables.current_level == "world10":
		if area.is_in_group("player") and PlayerVariables.quail_count >= 20:
			progress_bar.visible = true
			print("win quail count = " + str(PlayerVariables.quail_count))
			timer.start()
			
	if PlayerVariables.current_level == "world11":
		if area.is_in_group("player") and PlayerVariables.quail_count >= 20:
			progress_bar.visible = true
			print("win quail count = " + str(PlayerVariables.quail_count))
			timer.start()
			
	if PlayerVariables.current_level == "world12":
		if area.is_in_group("player") and PlayerVariables.quail_count >= 20:
			progress_bar.visible = true
			print("win quail count = " + str(PlayerVariables.quail_count))
			timer.start()
		else:
			print("you have no quails!")
	


func _on_timer_timeout():
	var earned_quails = PlayerVariables.quail_count
	PlayerVariables.quail_total = PlayerVariables.quail_total + earned_quails
	print_rich("[color=YELLOW][pulse]You have saved: [/pulse]" + str(PlayerVariables.quail_total) + "[color=YELLOW][pulse] quail![/pulse]") 
	get_tree().change_scene_to_file("res://win_screen.tscn")


func _on_area_exited(area):
	if area.is_in_group("player"):
		progress_bar.visible = false
		timer.stop()
