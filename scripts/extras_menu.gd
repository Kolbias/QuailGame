extends Control

func _ready() -> void:
	%QuailRescuedLabel.text = "[wave]Quail Rescued: " + str(PlayerVariables.quail_total)
func _on_exit_button_pressed() -> void:
	GlobalSignals.emit_signal("extras_menu_closed")
