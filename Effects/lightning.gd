extends DirectionalLight2D

@onready var timer = $Timer
@onready var thunder_sound = $AudioStreamPlayer2D
@export var time_min = 20
@export var time_max = 60
@onready var rand_num = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = randi_range(time_min, time_max)
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if energy > 0.5:
		energy = lerp(energy, 0.5, 0.1)


func _on_timer_timeout(): 
	energy = 4.4
	thunder_sound.play()
	get_random_time()
	timer.wait_time = rand_num
	print("getting new lighting strike in" + str(rand_num))

func get_random_time():
	rand_num = randi_range(time_min, time_max)
	
