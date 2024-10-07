extends Node2D

var MasterVolumeModifier
var MusicVolumeModifier
var SFXVolumeModifier
@onready var cards_prototype = $CardsPrototypeContainer

func _ready():
	pass # Replace with function body.

func _process(_delta):
	pass

func change_volume(bus, value):
	AudioServer.set_bus_volume_db(bus, value - 40)
