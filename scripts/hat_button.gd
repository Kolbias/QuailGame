extends Button

@export var hat_number = 0

func _ready() -> void:
	connect("button_down", _on_button_down)

func _on_button_down():
	PlayerVariables.current_hat = hat_number
