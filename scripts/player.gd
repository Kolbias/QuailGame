extends CharacterBody2D

@onready var sprite = get_node("AnimatedSprite2D")
@onready var quail_count_ui = $UI/Label
@onready var timer_ui = $UI/Timer
@onready var quail_baby = preload("res://quail_baby.tscn")
@onready var world = preload("res://world.gd")
@onready var timer = $Timer
@onready var egg_hatch_sound = $EggHatchSound
@onready var walk_sound = $WalkingSound
@onready var paused = false
@onready var unpause_button = $UI/UnpauseButton
@onready var game_over_ui = $UI/GameOverText
@onready var alive = true
@onready var particles = $CPUParticles2D
@onready var hurtbox = $Hurtbox
@onready var pause_quit_button = $UI/PauseQuitButton


func _ready():
	unpause_button.visible = false
	pause_quit_button.visible = false
	game_over_ui.visible = false 
	timer.start()


func _process(delta):
	var current_quail_count = PlayerVariables.quail_count
	var vel = Vector2()
	var speed = PlayerVariables.speed
	var moving = false 
	var move_left = Input.is_action_pressed("move_left")
	var move_right = Input.is_action_pressed("move_right")
	var move_down = Input.is_action_pressed("move_down")
	var move_up = Input.is_action_pressed("move_up")
	
	if move_left and alive == true:
		vel.x -= speed
		sprite.flip_h = true
		moving = true
	if move_right and alive == true:
		vel.x += speed
		sprite.flip_h = false
		moving = true
	if move_down and alive == true:
		vel.y += speed
		moving = true
	if move_up and alive == true:
		vel.y -= speed
		moving = true
	
	if moving:
		sprite.play("run")
		# walk_sound.play()
	else:
		sprite.play("idle")
	quail_count_ui.text = ("Quail count: " + str(current_quail_count))
	timer_ui.text = ("Time Remaining: " + str(int(timer.time_left)))
	
	move_and_collide(vel.normalized() * speed)
	
	if Input.is_action_just_pressed("pause") and paused == false:
		get_tree().paused = true
		unpause_button.visible = true
		pause_quit_button.visible = true
	
	if alive == false:
		particles.emitting = true
		
func _on_area_entered(_area: Area2D):
	self.queue_free()
	print("Game Over")



func _on_hurtbox_area_entered(area):
	if area.is_in_group("car"):
		PlayerVariables.quail_count = 0
		sprite.visible = false
		hurtbox.monitoring = true
		alive = false
		game_over_ui.visible = true
		print("Game Over")
	else:
		pass

func _on_quail_egg_quail_hatched():
	PlayerVariables.quail_count += 1
	egg_hatch_sound.play()
	var added_quail_count = PlayerVariables.quail_count
	print("Quail count: " + str(added_quail_count))


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://game_over.tscn")


func _on_unpause_button_button_down():
		unpause_button.visible = false
		pause_quit_button.visible = false
		get_tree().paused = false
		


func _on_play_again_button_button_down():
	print(PlayerVariables.current_level)
	PlayerVariables.quail_count = 0
	if PlayerVariables.current_level == "world1":
		get_tree().change_scene_to_file("res://world.tscn")
	if PlayerVariables.current_level == "world2":
		get_tree().change_scene_to_file("res://world2.tscn")
	if PlayerVariables.current_level == "world3":
		get_tree().change_scene_to_file("res://world3.tscn")


func _on_pause_quit_button_button_down():
	get_tree().change_scene_to_file("res://main_menu.tscn")

