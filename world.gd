extends Node2D

@onready var main_quail = get_node("Player")
@onready var quail_baby = preload("res://quail_baby.tscn")
# @export var background_scroll_speed = Vector2(0.15,0.15)
@onready var player_quail_amount = PlayerVariables.quail_count
#@onready var ui = %UICanvas
@onready var player = $Player


func _on_quail_egg_quail_hatched():
	var new_quail = quail_baby.instantiate()
	add_child(new_quail)
	GlobalSignals.emit_signal("egg_hatched")
	new_quail.position = main_quail.position

func _process(_delta):
	# ui.position = player.position
	# parallax.motion_offset += background_scroll_speed
	# night_parallax.motion_offset += background_scroll_speed
	pass
	
# Function to spawn quail, currently not working as World node is "Not ready" 
func spawn_quail():
	if PlayerVariables.quail_count > 0:
		var spawned_quail = 0
		var instance = quail_baby.instantiate()
		for n in player_quail_amount:
			add_child(instance)
			#print(n)
			instance.position = main_quail.position
			spawned_quail += 1
			continue
			if spawned_quail >= player_quail_amount:
				break
	else:
		pass
