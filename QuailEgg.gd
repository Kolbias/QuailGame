extends Area2D

@onready var timer = $Timer
@onready var sound = $AudioStreamPlayer2D
@onready var particles = preload("res://Effects/egg_hatch_particles.tscn")

signal quail_hatched
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_entered(_area):
	timer.start()


func _on_area_exited(_area):
	timer.stop()


func _on_timer_timeout():
	var instance = particles.instantiate()
	add_child(instance)
	sound.play()
	quail_hatched.emit()
	queue_free()
