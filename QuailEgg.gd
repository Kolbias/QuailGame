extends Area2D

@onready var timer = get_node("Timer")
signal quail_hatched
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	timer.start()


func _on_area_exited(area):
	timer.stop()


func _on_timer_timeout():
	quail_hatched.emit()
	queue_free()
