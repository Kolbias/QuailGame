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
@onready var boost_bar: ProgressBar = %BoostBar
@onready var mash_bar = %MashBar
enum States {IDLE, WALK, BOOST, BOOSTSTART, BOOSTSTOP, SETBOOST, SWIM, CALL, CALLSTART, DEAD}

var can_call = true
var can_boost = true
var state = States.IDLE

@onready var particles = $CPUParticles2D


func change_state(new_state):
	state = new_state

func _ready():
	GlobalSignals.connect("egg_hatched", _on_egg_hatched)
	%BoostBar.hide()
	GlobalSignals.connect("game_over", _on_game_over)
	print("Current level = " + str(PlayerVariables.current_level))
	timer.start()
	%PlayerCallTimer.connect("timeout", _on_player_call_timer_timeout)
func _process(delta: float) -> void:
	if %CallTimer.time_left <= 0:
		%CallBar.hide()
	if %CallTimer.time_left >= 1:
		%CallBar.show()
	if %MashBar.value <= 0:
		%MashBar.hide()
	if %MashBar.value >= 1 and can_boost:
		%MashBar.show()
	%CallBar.value = %CallTimer.time_left
	%BoostBar.value = %MashBar.value
	PlayerVariables.time_remaining = timer.time_left
	#print(timer.time_left)
	#print(PlayerVariables.time_remaining)
	%MashBar.value -= 2
func _physics_process(delta):

	var dir = Vector2()
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up") 
	input_vector = input_vector.normalized()
	
	var current_quail_count = PlayerVariables.quail_count
	var boost_started = Input.is_action_just_pressed("boost")
	var boost_ended = Input.is_action_just_released("boost")
	PlayerVariables.boost_cooldown = $BoostCooldown.time_left
	
	match state:
		States.IDLE:
			%HatAnimator.play("hat_idle")
			%BoostFeathers.emitting = false
			$StateDebug.text = "IDLE"
			if Input.is_action_pressed("ui_down"):
				change_state(States.WALK)
			if Input.is_action_pressed("ui_up"):
				change_state(States.WALK)
			if Input.is_action_pressed("ui_left"):
				change_state(States.WALK)
			if Input.is_action_pressed("ui_right"):
				change_state(States.WALK)
			sprite.play("idle")
			if Input.is_action_pressed("ui_accept"):
				if can_call:
					%PlayerCallTimer.start()
					change_state(States.CALLSTART)
		States.WALK:
			%HatAnimator.play("hat_run")
			%BoostFeathers.emitting = false
			%MashBar.show()
			%BoostBar.hide()
			#%MashBar.hide()
			$StateDebug.text = "WALK"
			sprite.play("run")
			if Input.is_action_just_pressed("boost") and can_boost:
				#can_boost = false
				change_state(States.SETBOOST)
			#if Input.is_action_just_released("boost"):
				#can_boost = true
			if input_vector == Vector2(0,0):
				change_state(States.IDLE)
			if input_vector.x < 0:
				sprite.flip_h = true
				$AnimatedSprite2D/Hats/Hat1.flip_h = true
				%Hats.position = Vector2(-5.5,-4)
			if input_vector.x > 0:
				sprite.flip_h = false
				$AnimatedSprite2D/Hats/Hat1.flip_h = false
				%Hats.position = Vector2(5.5,-4)
			speed = PlayerVariables.speed
			velocity = input_vector * speed
			#print(input_vector)
			move_and_slide()
		States.SETBOOST:
			%MashBar.hide()
			if input_vector.x < 0:
				sprite.flip_h = true
			if input_vector.x > 0:
				sprite.flip_h = false
			
			%MashBar.value += 20
			change_state(States.BOOSTSTART)
			speed = lerp(speed, boost_speed, 3.0 * delta)
			move_and_slide()
		States.BOOSTSTART:
			#%MashBar.hide()
			if input_vector.x < 0:
				sprite.flip_h = true
			if input_vector.x > 0:
				sprite.flip_h = false
			
			$StateDebug.text = "BOOST START"
			#$BoostTimer.start()
			velocity = input_vector.normalized() * speed
			speed = lerp(speed, boost_speed, 3.0 * delta)
			move_and_slide()
			change_state(States.BOOSTSTOP)
			
		States.BOOSTSTOP:
			%BoostFeathers.emitting = true
			sprite.play("boost")
			if input_vector.x < 0:
				sprite.flip_h = true
			if input_vector.x > 0:
				sprite.flip_h = false
			$StateDebug.text = "BOOST STOP"
			velocity = input_vector.normalized() * speed
			speed = lerp(speed, boost_speed, 2.0 * delta)
			move_and_slide()
			if Input.is_action_pressed("boost"):
				change_state(States.SETBOOST)
			if %MashBar.value <= 0:
				change_state(States.WALK)
			if %MashBar.value >= 90:
				change_state(States.BOOST)
			if input_vector == Vector2(0,0):
				change_state(States.WALK)
		States.BOOST:
			can_boost = false
			%MashBar.hide()
			%BoostBar.show()
			#$BoostTimer.start()
			#if input_vector.x < 0:
				#sprite.flip_h = true
			#if input_vector.x > 0:
				#sprite.flip_h = false
			#velocity = input_vector.normalized() * speed
			if %MashBar.value <= 0:
				change_state(States.WALK)
				can_boost = true
			move_and_slide()
			sprite.play("boost")
			$StateDebug.text = "BOOST"
			#speed = lerp(speed, boost_speed, 5.0 * delta)
		States.DEAD:
			$StateDebug.text = "DEAD"
			PlayerVariables.quail_count = 0
			sprite.visible = false
			hurtbox.monitoring = true
			alive = false
			%BoostBar.hide()
			if Input.is_action_just_pressed("restart"):
				PlayerVariables.quail_count = 0
				get_tree().reload_current_scene()
		States.SWIM:
			$StateDebug.text = "SWIM"
			if input_vector.x < 0:
				sprite.flip_h = true
			if input_vector.x > 0:
				sprite.flip_h = false
			velocity = input_vector * (speed * 0.5)
			sprite.play("swim")
			move_and_slide()
			
		States.CALLSTART:
			%CallBar.show()
			$StateDebug.text = "CALLSTART"
			%QuailCallSound.play()
			can_call = false
			%CallTimer.start()
			change_state(States.CALL)
		States.CALL:
			%CallParticles.emitting = true
			$StateDebug.text = "CALL"
			GlobalSignals.emit_signal("call_babies")
			
	for i in get_slide_collision_count():
			var c = get_slide_collision(i)
			if c.get_collider() is RigidBody2D:
				c.get_collider().apply_central_impulse(-c.get_normal() * push_amount)
	
	if Input.is_action_just_pressed("restart"):
		$RestartTimer.start()
		GlobalSignals.emit_signal("restart_level")
	if Input.is_action_just_released("restart"):
		$RestartTimer.stop()
		GlobalSignals.emit_signal("restart_level_stop")

	if alive == false:
		particles.emitting = true

# Car Collision
func _on_hurtbox_area_entered(area):
	if area.is_in_group("car"):
		if alive: 
			hit_sound.play()
		GlobalSignals.emit_signal("game_over")
		print("Game Over")
		
	if area.is_in_group("water"):
		in_water = true
		#PlayerVariables.speed = PlayerVariables.speed * 0.5
		change_state(States.SWIM)
						  
	if area.is_in_group("fire"):
		#print("Quail burning!!")
		#alive = false
		#sprite.visible = false
		print("fire detected by player")
		GlobalSignals.emit_signal("game_over")
		change_state(States.DEAD)
	else:
		pass

# Quail Egg hatch
func _on_quail_egg_quail_hatched():
	PlayerVariables.quail_count += 1
	timer.start(timer.time_left + 2.0)
	egg_hatch_sound.play()
	var added_quail_count = PlayerVariables.quail_count
	print("Quail count: " + str(added_quail_count))

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
		#PlayerVariables.speed = 100.0
		change_state(States.WALK)
func _on_game_over():
	change_state(States.DEAD)
	print("Player Died")


func _on_boost_timer_timeout():
	change_state(States.IDLE)
	#can_boost = false
	#$BoostTimer.stop()
	#$BoostCooldown.start()
	#%BoostBar.show()
	speed = PlayerVariables.speed
	print("timer stopped")
	
	
func _on_boost_cooldown_timeout():
	can_boost = true
	$BoostCooldown.stop()
	%BoostBar.hide()

func _on_egg_hatched():
	$Plus2Particle.emitting = true


func _on_restart_timer_timeout() -> void:
	GlobalSignals.emit_signal("restart_level_stop")
	PlayerVariables.quail_count = 0
	get_tree().reload_current_scene()
	
func _on_player_call_timer_timeout():
	print("player call timer time out")
	change_state(States.IDLE)


func _on_call_timer_timeout() -> void:
	if can_call == false:
		can_call = true
	else:
		pass
