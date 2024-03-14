extends Node2D

@onready var main_quail = get_node("Player")
@onready var quail_baby = preload("res://quail_baby.tscn")

func _on_quail_egg_quail_hatched():
	var new_quail = quail_baby.instantiate()
	add_child(new_quail)
	new_quail.position = main_quail.position
