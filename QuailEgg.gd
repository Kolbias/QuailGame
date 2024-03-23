extends Area2D

@onready var timer = $Timer
@onready var sound = $AudioStreamPlayer2D
@onready var particles = $EggHatchParticles
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
	sound.play()
	particles.emitting = true
	quail_hatched.emit()



func _on_egg_hatch_particles_finished():
	queue_free()
