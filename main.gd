extends Node2D


@export var scene: PackedScene


func _ready() -> void:
	GlobalSignals.connect("world_completed", _on_world_completed)
	GlobalSignals.connect("exit_win_screen", _on_exit_win_screen)
	GlobalSignals.connect("player_restarted", _on_player_restarted)
	GlobalSignals.connect("settings_menu_closed", _on_settings_menu_closed)
	GlobalSignals.connect("load_world", _on_world_loaded)
	GlobalSignals.connect("extras_menu_closed", _on_extras_menu_closed)
	
func _on_play_button_button_down() -> void:
	var instance = scene.instantiate()
	print(str(scene))
	%MainMenu.queue_free()
	self.add_child(instance)
	instance.position = Vector2(145,20)
	
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

func _on_player_restarted():
	var world = get_child(0)
	#var world_path = get_child(0).get_path()
	#print(world_path)
	var current_world = PlayerVariables.current_level
	print("player restarted current world: " + str(current_world))
	var path = "res://world" + str(current_world) + ".tscn"
	var scene = load(path)
	var instance = scene.instantiate()
	world.queue_free()
	add_child(instance)
	pass


func _on_settings_button_pressed() -> void:
	var current_scene = get_child(0)
	if current_scene.name == "MainMenu":
		%MainMenuVBox.hide()
		%SettingsMenu.show()
		
func _on_settings_menu_closed():
	var current_scene = self.get_child(0)
	print(current_scene.name)
	if current_scene.name == "MainMenu":
		%MainMenuVBox.show()
		%SettingsMenu.hide()


func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_world_loaded(scene):
	var current_scene = get_child(0)
	var new_scene = scene.instantiate()
	current_scene.queue_free()
	self.add_child(new_scene)


func _on_extras_button_pressed() -> void:
	var current_scene = get_child(0)
	if current_scene.name == "MainMenu":
		%MainMenuVBox.hide()
		%ExtrasMenu.show()

func _on_extras_menu_closed():
	var current_scene = self.get_child(0)
	print(current_scene.name)
	if current_scene.name == "MainMenu":
		%MainMenuVBox.show()
		%ExtrasMenu.hide()
