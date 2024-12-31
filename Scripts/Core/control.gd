extends Node2D

@onready var cards_prototype = $CardsPrototypeContainer
@onready var deck = [24, 24, 24, 24, 20, 20, 2, 2, 25, 25]
const const_deck = [24, 24, 24, 24, 20, 20, 2, 2, 25, 25]
@onready var play_music_background := false

func _ready():
	pass # Replace with function body.
 
func _process(_delta):
	if not get_viewport().has_focus() && not play_music_background:
		AudioServer.set_bus_mute(0, true)
	else:
		AudioServer.set_bus_mute(0, false)
		
func change_volume(bus, value):
	AudioServer.set_bus_volume_db(bus, linear_to_db(value / 100))
	AudioServer.set_bus_mute(bus, value < 1)