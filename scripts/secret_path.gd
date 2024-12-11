extends TileMapLayer


func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("secret path detected player")
		var tween = get_tree().create_tween()
		tween.tween_property(self, "modulate", Color(1,1,1,0), 0.5)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("secret path detected player")
		var tween = get_tree().create_tween()
		tween.tween_property(self, "modulate", Color(1,1,1,1), 0.5)
