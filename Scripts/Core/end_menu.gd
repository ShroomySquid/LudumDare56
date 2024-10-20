extends Control

@onready var victory = false
@onready var end_msg = $EndContainer/EndMessage
@onready var retry_btn = $EndContainer/RetryBtn

func _on_quit_btn_pressed():
	get_tree().quit()

func _on_retry_btn_pressed():
	Engine.time_scale = 1
	if victory:
		get_tree().change_scene_to_file("res://scenes/Core/deck_editor.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/Core/game.tscn")
