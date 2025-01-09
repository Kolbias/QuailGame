extends TextureButton

@export var world: PackedScene
@export var world_number: int

func _on_pressed() -> void:
	PlayerVariables.current_level = world_number
	GlobalSignals.emit_signal("load_world", world)
	
