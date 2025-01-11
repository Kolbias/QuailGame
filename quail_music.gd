extends AudioStreamPlayer2D

@export var tracks: Array[AudioStreamOggVorbis] = []

func _ready() -> void:
	GlobalSignals.connect("world_ready", _switch_music)
	stream = tracks[0]
	play()

func _switch_music(current_world):
	if current_world >= 4:
		stream = tracks[1]
		play()
