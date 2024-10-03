extends Control

func _ready():
	pass # Replace with function body.

func _process(_delta):
	pass

func _on_start_btn_pressed():
	get_tree().change_scene_to_file("res://scenes/Game.tscn")
