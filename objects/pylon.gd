extends RigidBody2D

@onready var animation = $Sprite2D
@onready var move_collision = $CollisionShape2D
@onready var can_move = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_move:
		move_collision.disabled = false
	else:
		move_collision.disabled = true


func _on_area_2d_area_entered(area):
	if area.is_in_group("car"):
		animation.play("squish")
		can_move = false
		

