extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%WorldLabel.text = "World " + str(PlayerVariables.current_level)
	get_parent().process_mode = Node.PROCESS_MODE_DISABLED
	var tween = get_tree().create_tween()
	tween.tween_property(%TextureRect, "modulate", Color(1,1,1,1), 1.5).set_trans(Tween.TRANS_SINE)
	await tween.finished
	tween.kill()
	var tween2 = get_tree().create_tween()
	tween2.tween_property(%TextureRect, "modulate", Color(1,1,1,0), 0.2)
	get_parent().process_mode = Node.PROCESS_MODE_INHERIT
