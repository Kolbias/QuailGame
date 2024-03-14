extends Area2D

@onready var sprite = get_node("AnimatedSprite2D")
# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(_on_area_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed := 100.0
	var moving := false 
	if Input.is_action_pressed("move_left"):
		position.x -= speed * delta
		sprite.flip_h = true
		moving = true
	elif Input.is_action_pressed("move_right"):
		position.x += speed * delta
		sprite.flip_h = false
		moving = true
	elif Input.is_action_pressed("move_down"):
		position.y += speed * delta
		moving = true
	elif Input.is_action_pressed("move_up"):
		position.y -= speed * delta
		moving = true
	
	if moving:
		sprite.play("run")
	else:
		sprite.play("idle")

func _on_area_entered(area: Area2D):
	self.queue_free()
	print("Game Over")
