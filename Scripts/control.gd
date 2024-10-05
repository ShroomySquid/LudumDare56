extends Node2D

var MasterVolumeModifier
var MusicVolumeModifier
var SFXVolumeModifier
@onready var cards_prototype = $CardsPrototypeContainer

func _ready():
	pass # Replace with function body.

func _process(_delta):
	pass
	#if Input.is_action_just_pressed("RightClick"):
	#	$SFXtest.play()

func change_volume(bus, value):
	AudioServer.set_bus_volume_db(bus, value - 40)
