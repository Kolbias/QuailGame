extends Node

var speed := 100.0
var boost_speed := 165.0
var quail_count := 0
var boost_cooldown := 0.0
var time_remaining := 0
var quail_collected := 0
var current_level = 1

var chall_rating1 := 10
var chall_rating2 := 12
var chall_rating3 := 16
var chall_rating4 := 18
var chall_rating5 := 20

#Vars to Save
var quail_total := 0
var world_scores := []

func _ready():
	if FileAccess.file_exists("user://savegame.json"):
		_on_load_game()
	else:
		_on_save_game()
	GlobalSignals.connect("save_game", _on_save_game)
	current_level = current_level
	#print(current_level)

func _process(delta):
	if quail_count < 0:
		quail_count = 0

func _on_save_game():
	var file = FileAccess.open("user://savegame.json", FileAccess.WRITE)
	var saved_data = {}
	#Add More Vars to save below
	saved_data["quail_total"] = quail_total
	
	var json = JSON.stringify(saved_data)
	file.store_string(json)
	file.close()
	
func _on_load_game():
	var file = FileAccess.open("user://savegame.json", FileAccess.READ)
	var json = file.get_as_text()
	var saved_data = JSON.parse_string(json)
	#Add more Vars to load below
	quail_total = saved_data["quail_total"]

	file.close()
