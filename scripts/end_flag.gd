extends Area2D
@onready var timer = $Timer
@onready var eggs_required_ui = $Control/VBoxContainer/Label
@onready var progress_bar = $Control/VBoxContainer/ProgressBar

@onready var cr1 = PlayerVariables.chall_rating1
@onready var cr2 = PlayerVariables.chall_rating2
@onready var cr3 = PlayerVariables.chall_rating3
@onready var cr4 = PlayerVariables.chall_rating4
@onready var cr5 = PlayerVariables.chall_rating5

func _ready():
	# Quail Amount needed for each level UI Text
	progress_bar.visible = false
	if PlayerVariables.current_level == 1:
		eggs_required_ui.text = str(cr1) + "+ Quail"
	if PlayerVariables.current_level == 2:
		eggs_required_ui.text = str(cr2) + "+ Quail"
	if PlayerVariables.current_level == 3:
		eggs_required_ui.text = str(cr3) + "+ Quail"
	if PlayerVariables.current_level == 4:
		eggs_required_ui.text = str(cr3) + "+ Quail"
	if PlayerVariables.current_level == 5:
		eggs_required_ui.text = str(cr3) + "+ Quail"
	if PlayerVariables.current_level == 6:
		eggs_required_ui.text = str(cr3) + "+ Quail"
	if PlayerVariables.current_level == 7:
		eggs_required_ui.text = str(cr3) + "+ Quail"
	if PlayerVariables.current_level == 8:
		eggs_required_ui.text = str(cr3) + "+ Quail"
	if PlayerVariables.current_level == 9:
		eggs_required_ui.text = str(cr4) + "+ Quail"
	if PlayerVariables.current_level == 10:
		eggs_required_ui.text = str(cr4) + "+ Quail"
	if PlayerVariables.current_level == 11:
		eggs_required_ui.text = str(cr3) + "+ Quail"
	if PlayerVariables.current_level == 12:
		eggs_required_ui.text = str(cr3) + "+ Quail"
func _process(_delta):
	progress_bar.value = timer.time_left

# Quail Amount needed for each level
func _on_area_entered(area):
	if PlayerVariables.current_level == 1:
		if area.is_in_group("player") and PlayerVariables.quail_count >= cr1:
			progress_bar.visible = true
			print("win quail count = " + str(PlayerVariables.quail_count))
			timer.start()
		else:
			print("you have no quails!")
	
	if PlayerVariables.current_level == 2:
		if area.is_in_group("player") and PlayerVariables.quail_count >= cr2:
			progress_bar.visible = true
			print("win quail count = " + str(PlayerVariables.quail_count))
			timer.start()
		else:
			print("you have no quails!")
	
	if PlayerVariables.current_level == 3:
		if area.is_in_group("player") and PlayerVariables.quail_count >= cr3:
			progress_bar.visible = true
			print("win quail count = " + str(PlayerVariables.quail_count))
			timer.start()
	
	if PlayerVariables.current_level == 4:
		if area.is_in_group("player") and PlayerVariables.quail_count >= cr2:
			progress_bar.visible = true
			print("win quail count = " + str(PlayerVariables.quail_count))
			timer.start()
	
	if PlayerVariables.current_level == 5:
		if area.is_in_group("player") and PlayerVariables.quail_count >= cr3:
			progress_bar.visible = true
			print("win quail count = " + str(PlayerVariables.quail_count))
			timer.start()
	
	if PlayerVariables.current_level == 6:
		if area.is_in_group("player") and PlayerVariables.quail_count >= cr3:
			progress_bar.visible = true
			print("win quail count = " + str(PlayerVariables.quail_count))
			timer.start()
			
	if PlayerVariables.current_level == 7:
		if area.is_in_group("player") and PlayerVariables.quail_count >= cr3:
			progress_bar.visible = true
			print("win quail count = " + str(PlayerVariables.quail_count))
			timer.start()
			
	if PlayerVariables.current_level == 8:
		if area.is_in_group("player") and PlayerVariables.quail_count >= cr3:
			progress_bar.visible = true
			print("win quail count = " + str(PlayerVariables.quail_count))
			timer.start()
			
	if PlayerVariables.current_level == 9:
		if area.is_in_group("player") and PlayerVariables.quail_count >= cr4:
			progress_bar.visible = true
			print("win quail count = " + str(PlayerVariables.quail_count))
			timer.start()
			
	if PlayerVariables.current_level == 10:
		if area.is_in_group("player") and PlayerVariables.quail_count >= cr4:
			progress_bar.visible = true
			print("win quail count = " + str(PlayerVariables.quail_count))
			timer.start()
			
	if PlayerVariables.current_level == 11:
		if area.is_in_group("player") and PlayerVariables.quail_count >= cr4:
			progress_bar.visible = true
			print("win quail count = " + str(PlayerVariables.quail_count))
			timer.start()
			
	if PlayerVariables.current_level == 12:
		if area.is_in_group("player") and PlayerVariables.quail_count >= cr4:
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
