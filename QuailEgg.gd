extends Area2D

@onready var timer = $Timer
@onready var sound = $AudioStreamPlayer2D
@onready var particles = $EggHatchParticles
@onready var sprite = $Sprite2D
signal quail_hatched



func _on_area_entered(area):
	if area.is_in_group("player"):
		$Exclaimation.show()
		var tween = create_tween().set_loops()
		tween.tween_property($Exclaimation, "position",Vector2(0,-15),0.2).from(Vector2(0,-9)).set_trans(Tween.TRANS_BOUNCE)
		tween.tween_property($Exclaimation, "position",Vector2(0,-9),0.2).from(Vector2(0,-15)).set_trans(Tween.TRANS_BOUNCE)
		timer.start()


func _on_area_exited(area):
	if area.is_in_group("player"):

		$Exclaimation.hide()
		timer.stop()


func _on_timer_timeout():
	$Exclaimation.hide()
	sprite.visible = false
	sound.play()
	particles.emitting = true
	quail_hatched.emit()



func _on_egg_hatch_particles_finished():
	queue_free()
