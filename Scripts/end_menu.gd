extends Control

@onready var victory = false
@onready var end_msg = $EndContainer/EndMessage
@onready var retry_btn = $EndContainer/RetryBtn

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _on_quit_btn_pressed():
	get_tree().quit()

func _on_retry_btn_pressed():
	if victory:
		get_tree().change_scene_to_file("res://scenes/deck_editor.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/game.tscn")
