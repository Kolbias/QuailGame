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


func _ready():
	unpause_button.visible = false
	game_over_ui.visible = false 
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var current_quail_count = PlayerVariables.quail_count
	var vel = Vector2()
	var speed = PlayerVariables.speed
	var moving = false 
	if Input.is_action_pressed("move_left") and alive == true:
		position.x -= speed * delta
		sprite.flip_h = true
		moving = true
	elif Input.is_action_pressed("move_right") and alive == true:
		position.x += speed * delta
		sprite.flip_h = false
		moving = true
	elif Input.is_action_pressed("move_down") and alive == true:
		position.y += speed * delta
		moving = true
	elif Input.is_action_pressed("move_up") and alive == true:
		position.y -= speed * delta
		moving = true
	
	if moving:
		sprite.play("run")
		# walk_sound.play()
	else:
		sprite.play("idle")
	quail_count_ui.text = ("Quail count: " + str(current_quail_count))
	timer_ui.text = ("Time Remaining: " + str(int(timer.time_left)))
	
	move_and_collide(vel* delta)
	
	if Input.is_action_just_pressed("pause") and paused == false:
		get_tree().paused = true
		unpause_button.visible = true
	
	
func _on_area_entered(_area: Area2D):
	self.queue_free()
	print("Game Over")



func _on_hurtbox_area_entered(area):
	if area.is_in_group("car"):
		PlayerVariables.quail_count = 0
		sprite.visible = false
		alive = false
		# get_tree().change_scene_to_file("res://game_over.tscn")
		game_over_ui.visible = true
		print("Game Over")
		# self.queue_free()
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
		get_tree().paused = false
		


func _on_play_again_button_button_down():
	print(PlayerVariables.current_level)
	if PlayerVariables.current_level == "world1":
		get_tree().change_scene_to_file("res://world.tscn")
	if PlayerVariables.current_level == "world2":
		get_tree().change_scene_to_file("res://world2.tscn")
	if PlayerVariables.current_level == "world3":
		get_tree().change_scene_to_file("res://world3.tscn")
