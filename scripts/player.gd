extends CharacterBody2D

# Gameplay Variables
@onready var alive := true
@onready var hurtbox := $Hurtbox
@onready var sprite := get_node("AnimatedSprite2D")
@onready var quail_baby := preload("res://quail_baby.tscn")
@onready var world := preload("res://world.gd")
@onready var timer := $Timer
@onready var egg_hatch_sound := $EggHatchSound
@onready var hit_sound := $HitSound
@onready var in_water := false
@onready var push_amount := 10.0
@onready var speed = PlayerVariables.speed
@onready var boost_speed = PlayerVariables.boost_speed

enum States {IDLE, WALK, BOOST, BOOSTSTART, SWIM}

var can_boost = true
var state = States.IDLE

@onready var particles = $CPUParticles2D


func change_state(new_state):
	state = new_state

func _ready():
	print("Current level = " + str(PlayerVariables.current_level))
	timer.start()


func _physics_process(delta):
	var dir = Vector2()
	var current_quail_count = PlayerVariables.quail_count
	var boost_started = Input.is_action_just_pressed("boost")
	var boost_ended = Input.is_action_just_released("boost")
	PlayerVariables.boost_cooldown = $BoostCooldown.time_left
	
	match state:
		States.IDLE:
			#$StateDebug.text = "IDLE"
			if Input.is_action_pressed("move_down"):
				change_state(States.WALK)
			if Input.is_action_pressed("move_up"):
				change_state(States.WALK)
			if Input.is_action_pressed("move_left"):
				change_state(States.WALK)
			if Input.is_action_pressed("move_right"):
				change_state(States.WALK)
			sprite.play("idle")
		States.WALK:
			#$StateDebug.text = "WALK"
			var move_left = Input.is_action_pressed("move_left")
			var move_right = Input.is_action_pressed("move_right")
			var move_down = Input.is_action_pressed("move_down")
			var move_up = Input.is_action_pressed("move_up")
			var boost = Input.is_action_pressed("boost")
			if move_left and alive == true:
				dir.x -= speed
				sprite.flip_h = true
			if move_right and alive == true:
				dir.x += speed
				sprite.flip_h = false
			if move_down and alive == true:
				dir.y += speed
			if move_up and alive == true:
				dir.y -= speed
			velocity = dir.normalized() * speed
			move_and_slide()
			sprite.play("run")
			if Input.is_action_just_pressed("boost") and can_boost:
				change_state(States.BOOSTSTART)
			if Input.is_action_just_released("move_down"):
				change_state(States.IDLE)
			if Input.is_action_just_released("move_up"):
				change_state(States.IDLE)
			if Input.is_action_just_released("move_left"):
				change_state(States.IDLE)
			if Input.is_action_just_released("move_right"):
				change_state(States.IDLE)
		States.BOOSTSTART:
			can_boost = false
			$StateDebug.text = "BOOST START"
			$BoostTimer.start()
			change_state(States.BOOST)
		States.BOOST:
			var move_left = Input.is_action_pressed("move_left")
			var move_right = Input.is_action_pressed("move_right")
			var move_down = Input.is_action_pressed("move_down")
			var move_up = Input.is_action_pressed("move_up")
			var boost = Input.is_action_pressed("boost")
			if move_left and alive == true:
				dir.x -= speed
				sprite.flip_h = true
			if move_right and alive == true:
				dir.x += speed
				sprite.flip_h = false
			if move_down and alive == true:
				dir.y += speed
			if move_up and alive == true:
				dir.y -= speed
			velocity = dir.normalized() * speed
			move_and_slide()
			sprite.play("boost")
			$StateDebug.text = "BOOST"
			speed = lerp(speed, boost_speed, 5.0 * delta)

	velocity = dir.normalized() * speed
	move_and_slide()
	
	for i in get_slide_collision_count():
			var c = get_slide_collision(i)
			if c.get_collider() is RigidBody2D:
				c.get_collider().apply_central_impulse(-c.get_normal() * push_amount)
	
	if Input.is_action_just_pressed("restart"):
		PlayerVariables.quail_count = 0
		get_tree().reload_current_scene()

	if alive == false:
		particles.emitting = true

func move():
	var dir = Vector2()
	var moving = false 
	var move_left = Input.is_action_pressed("move_left")
	var move_right = Input.is_action_pressed("move_right")
	var move_down = Input.is_action_pressed("move_down")
	var move_up = Input.is_action_pressed("move_up")
	var boost = Input.is_action_pressed("boost")
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
	velocity = dir.normalized() * speed
	move_and_slide()
	sprite.play("run")

	
# Car Collision
func _on_hurtbox_area_entered(area):
	if area.is_in_group("car"):
		if alive: 
			hit_sound.play()
		PlayerVariables.quail_count = 0
		sprite.visible = false
		hurtbox.monitoring = true
		alive = false
		GlobalSignals.emit_signal("game_over")
		print("Game Over")
		
	if area.is_in_group("water"):
		in_water = true
		PlayerVariables.speed = PlayerVariables.speed * 0.5
		
	if area.is_in_group("fire"):
		print("Quail burning!!")
		alive = false
		sprite.visible = false
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



func _on_hurtbox_area_exited(area):
	if area.is_in_group("water"):
		in_water = false
		PlayerVariables.speed = 100.0

func _on_game_over():
	print("Player Died")


func _on_boost_timer_timeout():
	change_state(States.IDLE)
	can_boost = false
	$BoostTimer.stop()
	$BoostCooldown.start()
	speed = PlayerVariables.speed
	print("timer stopped")



func _on_boost_cooldown_timeout():
	can_boost = true
	$BoostCooldown.stop()

