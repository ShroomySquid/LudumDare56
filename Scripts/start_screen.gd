extends Control

@onready var is_settings_on := false
@onready var settings = $CanvasLayer/Settings
@onready var menu = $CanvasLayer/MenuContainer

func _ready():
	settings.hide()

func _process(_delta):
	pass

func _on_start_btn_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_settings_btn_pressed():
	menu.hide()
	settings.show()

func _on_settings_exit_settings():
	menu.show()
	settings.hide()
