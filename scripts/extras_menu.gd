extends Control


func _on_exit_button_pressed() -> void:
	GlobalSignals.emit_signal("extras_menu_closed")
