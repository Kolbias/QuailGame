extends Button

@export var hat_number = 0
@export var hat_string = ""

func _ready() -> void:
	connect("button_down", _on_button_down)
	if !PlayerVariables.unlocked_hats.has(hat_string):
		self.disabled = true
	else:
		self.disabled = false

func _on_button_down():
	PlayerVariables.current_hat = hat_number
