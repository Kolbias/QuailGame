extends CharacterBody2D

# @onready var player := preload("res://player.tscn")
@onready var root_node = get_parent()
@onready var player = root_node.get_node("Player")
@onready var animation_player = get_node("AnimatedSprite2D")

signal quail_killed

func _ready():
	add_to_group("quail_babies")
	animation_player.play("default", -1, randf_range(0.7, 1.0))


func _process(delta):
	var speed = 4
	var vel = (player.position - position) * speed
	if vel.x < 0:
		animation_player.flip_h = true
	else:
		animation_player.flip_h = false
	
	move_and_collide(vel * delta)

func _on_hurtbox_area_entered(area):
	if area.is_in_group("car"):
		PlayerVariables.quail_count -= 1
	self.queue_free()

func _on_quail_killed():
	quail_killed.emit()