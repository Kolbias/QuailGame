extends TextureButton

@export var world: PackedScene

func _on_pressed() -> void:
	GlobalSignals.emit_signal("load_world", world)
