extends Node2D


@export var scene: PackedScene

func _on_play_button_button_down() -> void:
	GlobalSignals.connect("world_completed", _on_world_completed)
	GlobalSignals.connect("exit_win_screen", _on_exit_win_screen)
	var instance = scene.instantiate()
	%MainMenu.queue_free()
	self.add_child(instance)
	#instance.position = Vector2(145,20)
	
func _on_world_completed():
	var world = get_child(0)
	world.queue_free()
	scene = load("res://win_screen.tscn")
	var instance = scene.instantiate()
	self.add_child(instance)
	
func _on_exit_win_screen(path):
	var world = get_child(0)
	world.queue_free()
	scene = load(path)
	print(path)
	var instance = scene.instantiate()
	self.add_child(instance)
