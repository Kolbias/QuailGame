extends Node

var speed := 100.0
var boost_speed := 165.0
var quail_count := 0
var boost_cooldown := 0.0
var time_remaining := 0
var quail_collected := 0
var current_level := 1

var chall_rating1 := 10
var chall_rating2 := 12
var chall_rating3 := 16
var chall_rating4 := 18
var chall_rating5 := 20

#Vars to Save
var quail_total := 23
var quail_rescue_level := 0
var randomly_recieved_hats := []

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


#hat unlocks
var hat_path = [
	"res://assets/player/QuailHat1.png",
	"res://assets/player/QuailHat2.png",
	"res://assets/player/QuailHat3.png",
	"res://assets/player/QuailHat4.png",
	"res://assets/player/QuailHat5.png",
	"res://assets/player/QuailHat6.png",
	"res://assets/player/QuailHat7.png",
	"res://assets/player/QuailHat8.png",
	"res://assets/player/QuailHat9.png",
	"res://assets/player/QuailHat10.png",
	"res://assets/player/QuailHat11.png",
	"res://assets/player/QuailHat12.png",
	"res://assets/player/QuailHat13.png",
	"res://assets/player/QuailHat14.png",
	"res://assets/player/QuailHat15.png",
]

var current_hat = 0
var unlocked_hats := []
#var hat_1 = false
#var hat_2 = false
#var hat_3 = false
#var hat_4 = false
#var hat_5 = false
#var hat_6 = false
#var hat_7 = false
#var hat_8 = false


func _ready():
	#GlobalSignals.emit_signal("hat_selected", _on_hat_selected)
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
	quail_rescue_level = quail_total
	
func _on_save_game():
	var file = FileAccess.open("user://savegame.json", FileAccess.WRITE)
	var saved_data = {}
	#Add More Vars to save below
	saved_data["quail_total"] = quail_total
	saved_data["world_1_score"] = world_1_hs
	saved_data["world_2_score"] = world_2_hs
	saved_data["world_3_score"] = world_3_hs
	saved_data["world_4_score"] = world_4_hs
	saved_data["world_5_score"] = world_5_hs
	saved_data["world_6_score"] = world_6_hs
	saved_data["world_7_score"] = world_7_hs
	saved_data["world_8_score"] = world_8_hs
	saved_data["world_9_score"] = world_9_hs
	saved_data["world_10_score"] = world_10_hs
	saved_data["world_11_score"] = world_11_hs
	saved_data["world_12_score"] = world_12_hs
	saved_data["world_13_score"] = world_13_hs
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
	world_2_hs = saved_data["world_2_score"]
	world_3_hs = saved_data["world_3_score"]
	world_4_hs = saved_data["world_4_score"]
	world_5_hs = saved_data["world_5_score"]
	world_6_hs = saved_data["world_6_score"]
	world_7_hs = saved_data["world_7_score"]
	world_8_hs = saved_data["world_8_score"]
	world_9_hs = saved_data["world_9_score"]
	world_10_hs = saved_data["world_10_score"]
	world_11_hs = saved_data["world_11_score"]
	world_12_hs = saved_data["world_12_score"]
	world_13_hs = saved_data["world_13_score"]
	#orld_scores[0] = saved_data["world_1_highscore"]
	#for i in world_scores:
		#i = saved_data[i]
	file.close()
