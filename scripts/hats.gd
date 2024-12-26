extends Node2D

var texture: Texture2D
var current_hat = PlayerVariables.current_hat

func _ready() -> void:
	print("Current hat: " + str(current_hat))
	#GlobalSignals.connect("hat_selected", _on_hat_selected)
	if current_hat == 0:
		self.hide()
	if current_hat >= 1:
		self.show()
		texture = load("res://assets/player/QuailHat" + str(current_hat)+ ".png")
		%Hat1.texture = texture

func _on_hat_selected(num):
	current_hat = num
