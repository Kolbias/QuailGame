extends Area2D

@onready var timer = $Timer
@onready var sound = $AudioStreamPlayer2D
@onready var particles = $EggHatchParticles
@onready var sprite = $Sprite2D
signal quail_hatched

func _on_area_entered(area):
	if area.is_in_group("player"):
		timer.start()


func _on_area_exited(area):
	if area.is_in_group("player"):
		timer.stop()


func _on_timer_timeout():
	sprite.visible = false
	sound.play()
	particles.emitting = true
	quail_hatched.emit()



func _on_egg_hatch_particles_finished():
	queue_free()
