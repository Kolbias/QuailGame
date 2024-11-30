extends CharacterBody2D

# @onready var player := preload("res://player.tscn")
@onready var root_node = get_parent()
@onready var player = root_node.get_node("Player")
@onready var animation_player = get_node("AnimatedSprite2D")
@onready var hit_sound = $CarDeathSound
@onready var water_sound = $WaterDeathSound
@onready var spirit_particle = $SpiritParticle
@onready var splash_particle = $SplashParticle
@onready var sprite = $AnimatedSprite2D
@onready var alive = true

signal quail_killed

func _ready():
	GlobalSignals.connect("call_babies", _on_call_babies)
	%CallTimer.connect("timeout", _on_call_timer_timeout)
	add_to_group("quail_babies")
	animation_player.play("default", -1, randf_range(0.7, 1.0))


func _process(delta):
	var speed = 4
	var vel = (player.position - position) * speed
	if vel.x < 0:
		animation_player.flip_h = true
	else:
		animation_player.flip_h = false
	
	move_and_collide(vel * delta)

func _on_hurtbox_area_entered(area):
	if area.is_in_group("car"):
		if alive:
			hit_sound.playing = true
			alive = false
			spirit_particle.emitting = true
			sprite.visible = false
			PlayerVariables.quail_count -= 1
	if area.is_in_group("water"):
		print("water detected")
		if alive:
			splash_particle.emitting = true
			alive = false
			water_sound.playing = true
			spirit_particle.emitting = true
			sprite.visible = false
			PlayerVariables.quail_count -= 1
	if area.is_in_group("fire"):
		print("fire detected by baby")
		if alive:
			alive = false
			hit_sound.playing = true
			spirit_particle.emitting = true
			sprite.visible = false
			PlayerVariables.quail_count -= 1
		else:
			pass

func _on_quail_killed():
	quail_killed.emit()


func _on_audio_stream_player_2d_finished():
	pass


func _on_cpu_particles_2d_finished():
	self.queue_free()

func _on_call_babies():
	print("Call Babies Signal Recieved by baby")
	#$CollisionShape2D.disabled = true
	$CollisionShape2D.shape.radius = 1
	%CallTimer.start()

func _on_call_timer_timeout():
	var tween = get_tree().create_tween()
	tween.tween_property($CollisionShape2D.shape, "radius", 4, 1.0)
	#$CollisionShape2D.disabled = false
