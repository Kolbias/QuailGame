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
var world_scores := {
	"World1_quail_score": 0,
	"World2_quail_score": 0,
	"World3_quail_score": 0,
	"World4_quail_score": 0,
	"World5_quail_score": 0,
	"World6_quail_score": 0,
	"World7_quail_score": 0,
	"World8_quail_score": 0,
	"World9_quail_score": 0,
	"World10_quail_score": 0,
	"World11_quail_score": 0,
	"World12_quail_score": 0,
	"World13_quail_score": 0,
}
var world_1_hs = 0
var world_2_hs = 0
var world_3_hs = 0
var world_4_hs = 0
var world_5_hs = 0
var world_6_hs = 0
var world_7_hs = 0
var world_8_hs = 0
var world_9_hs = 0
var world_10_hs = 0
var world_11_hs = 0
var world_12_hs = 0
var world_13_hs = 0

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
	saved_data["world_1_score"] = world_1_hs 
	#for i in world_scores:
		#var s = "world_" + str(i) + "_score"
		#saved_data[s] = world_scores[0]
	#for i in world_scores:
		#saved_data = i
	#saved_data["world_1_highscore"] = world_scores[0]
	var json = JSON.stringify(saved_data)
	file.store_string(json)
	file.close()
	
func _on_load_game():
	var file = FileAccess.open("user://savegame.json", FileAccess.READ)
	var json = file.get_as_text()
	var saved_data = JSON.parse_string(json)
	#Add more Vars to load below
	quail_total = saved_data["quail_total"]
	world_1_hs = saved_data["world_1_score"]
	
	#orld_scores[0] = saved_data["world_1_highscore"]
	#for i in world_scores:
		#i = saved_data[i]
	file.close()
