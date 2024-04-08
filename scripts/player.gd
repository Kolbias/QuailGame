extends CharacterBody2D

# Gameplay Variables
@onready var alive = true
@onready var hurtbox = $Hurtbox
@onready var sprite = get_node("AnimatedSprite2D")
@onready var quail_baby = preload("res://quail_baby.tscn")
@onready var world = preload("res://world.gd")
@onready var timer = $Timer
@onready var egg_hatch_sound = $EggHatchSound
@onready var hit_sound = $HitSound
@onready var in_water = false
@onready var push_amount = 10.0

## Gameplay UI
#@onready var quail_count_ui = $CanvasLayer/UI/Control/QuailCount
#@onready var timer_ui = $CanvasLayer/UI/Control/Timer
#
## Paused Variables
#@onready var paused = falses
#@onready var unpause_button = $CanvasLayer/UI/Control/VBoxContainer/UnpauseButton
#@onready var pause_quit_button = $CanvasLayer/UI/Control/VBoxContainer/PauseQuitButton
#@onready var pause_retry = $CanvasLayer/UI/Control/VBoxContainer/PauseRetry
#@onready var game_over_ui = $CanvasLayer/UI/GameOverText

# Effects Variables
@onready var particles = $CPUParticles2D




func _ready():
	#Tryin to spawn Babies between levels
	#if PlayerVariables.quail_count > 0:
		#var instance = quail_baby.instantiate()
		#for x in PlayerVariables.quail_count:
			#add_child(instance)
			
	print("Current level = " + PlayerVariables.current_level)
	#unpause_button.visible = false
	#pause_quit_button.visible = false
	#pause_retry.visible = false
	#game_over_ui.visible = false 
	timer.start()


func _process(delta):
	var current_quail_count = PlayerVariables.quail_count
	var dir = Vector2()
	var speed = PlayerVariables.speed
	var moving = false 
	var move_left = Input.is_action_pressed("move_left")
	var move_right = Input.is_action_pressed("move_right")
	var move_down = Input.is_action_pressed("move_down")
	var move_up = Input.is_action_pressed("move_up")

	
# Movement
	if move_left and alive == true:
		dir.x -= speed
		sprite.flip_h = true
		moving = true
	if move_right and alive == true:
		dir.x += speed
		sprite.flip_h = false
		moving = true
	if move_down and alive == true:
		dir.y += speed
		moving = true
	if move_up and alive == true:
		dir.y -= speed
		moving = true
	
	
	if moving:
		sprite.play("run")
		if in_water:
				sprite.play("swim")
	elif in_water and moving == false:
		sprite.play("swim")
		
	else:
		sprite.play("idle")
	
	#quail_count_ui.text = ("Quail count: " + str(current_quail_count))
	#timer_ui.text = ("Time Remaining: " + str(int(timer.time_left)))
	velocity = dir.normalized() * speed
	move_and_slide()
	
	for i in get_slide_collision_count():
			var c = get_slide_collision(i)
			if c.get_collider() is RigidBody2D:
				c.get_collider().apply_central_impulse(-c.get_normal() * push_amount)
	
	if Input.is_action_just_pressed("restart"):
		PlayerVariables.quail_count = 0
		get_tree().reload_current_scene()
	
# Pause
	#if Input.is_action_just_pressed("pause") and paused == false:
		#get_tree().paused = true
		#unpause_button.visible = true
		#pause_retry.visible = true
		#pause_quit_button.visible = true
	
	if alive == false:
		particles.emitting = true
		

# Car Collision
func _on_hurtbox_area_entered(area):
	if area.is_in_group("car"):
		if alive: 
			hit_sound.play()
		PlayerVariables.quail_count = 0
		sprite.visible = false
		hurtbox.monitoring = true
		alive = false
		#game_over_ui.visible = true
		print("Game Over")
		
	if area.is_in_group("water"):
		in_water = true
		PlayerVariables.speed = PlayerVariables.speed * 0.5
		
	if area.is_in_group("fire"):
		print("Quail burning!!")
		alive = false
		sprite.visible = false
		#game_over_ui.visible = true
	else:
		pass

# Quail Egg hatch
func _on_quail_egg_quail_hatched():
	PlayerVariables.quail_count += 1
	egg_hatch_sound.play()
	var added_quail_count = PlayerVariables.quail_count
	print("Quail count: " + str(added_quail_count))

# End Flag
func _on_timer_timeout():
	get_tree().change_scene_to_file("res://game_over.tscn")

# Unpause
#func _on_unpause_button_button_down():
		#unpause_button.visible = false
		#pause_quit_button.visible = false
		#pause_retry.visible = false
		#get_tree().paused = false
		

# Play Again 
func _on_play_again_button_button_down():
	print(PlayerVariables.current_level)
	PlayerVariables.quail_count = 0
	if PlayerVariables.current_level == "world1" or "world":
		get_tree().reload_current_scene()
	if PlayerVariables.current_level == "world2":
		get_tree().change_scene_to_file("res://world2.tscn")
	if PlayerVariables.current_level == "world3":
		get_tree().change_scene_to_file("res://world3.tscn")
	else:
		pass
		#get_tree().change_scene_to_file("res://" + PlayerVariables.current_level + ".tscn")

#
#func _on_pause_quit_button_button_down():
	#get_tree().change_scene_to_file("res://main_menu.tscn")
#
#
#
#func _on_pause_retry_button_down():
	#PlayerVariables.quail_count = 0
	#get_tree().paused = false
	#get_tree().reload_current_scene()


func _on_hurtbox_area_exited(area):
	if area.is_in_group("water"):
		in_water = false
		PlayerVariables.speed = 100.0
