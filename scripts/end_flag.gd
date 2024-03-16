extends Area2D
@onready var timer = $Timer



func _on_area_entered(area):
	if area.is_in_group("player") and PlayerVariables.quail_count > 0:
		print("win quail count = " + str(PlayerVariables.quail_count))
		timer.start()
	else:
		print("you have no quails!")


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://win_screen.tscn")


func _on_area_exited(area):
	if area.is_in_group("player"):
		timer.stop()
