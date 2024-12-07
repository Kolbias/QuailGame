extends Control

var master_bus = AudioServer.get_bus_index("Master")
var sfx_bus = AudioServer.get_bus_index("sfx")
var music_bus = AudioServer.get_bus_index("music")

func _ready() -> void:
	%MasterSlider.value_changed.connect(_master_slider_value_changed)
	%SFXSlider.value_changed.connect(_sfx_slider_value_changed)
	%MusicSlider.value_changed.connect(_music_slider_value_changed)

func _master_slider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, linear_to_db(value))
	
func _sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(value))
	
func _music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value))

func _on_exit_button_pressed() -> void:
	GlobalSignals.emit_signal("settings_menu_closed")
