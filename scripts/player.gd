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
# Called when the node enters the scene tree for the first time.
func _ready():
	unpause_button.visible = false
	# var quails = PlayerVariables.quail_count
	timer.start()
	#if quails > 0:
		#var quail_amount = quails
		#for n in quail_amount:
			#var instance = quail_baby.instantiate()
			#get_parent().add_child(instance)
			#instance.position = position
			#print("spawned quail baby")
	#else:
		#pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var current_quail_count = PlayerVariables.quail_count
	var vel = Vector2()
	var speed = PlayerVariables.speed
	var moving := false 
	if Input.is_action_pressed("move_left"):
		position.x -= speed * delta
		sprite.flip_h = true
		moving = true
	elif Input.is_action_pressed("move_right"):
		position.x += speed * delta
		sprite.flip_h = false
		moving = true
	elif Input.is_action_pressed("move_down"):
		position.y += speed * delta
		moving = true
	elif Input.is_action_pressed("move_up"):
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
		get_tree().change_scene_to_file("res://game_over.tscn")
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
		
