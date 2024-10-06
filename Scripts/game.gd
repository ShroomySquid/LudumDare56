extends Node2D

@onready var is_paused := false
@onready var settings_on := false

func _ready():
	$CanvasLayer/MenuContainer.hide()
	$CanvasLayer/Settings.hide()

func _process(_delta):
	if Input.is_action_just_pressed("esc") && not settings_on:
		pause_trigger()

func pause_trigger():
	if (is_paused):
		$CanvasLayer/MenuContainer.hide()
		$CanvasLayer/PauseBtn.show()
		is_paused = false
		Engine.time_scale = 1
	else:
		$CanvasLayer/MenuContainer.show()
		$CanvasLayer/PauseBtn.hide()
		Engine.time_scale = 0
		is_paused = true

func _on_pause_btn_pressed():
	if not settings_on:
		pause_trigger()

func _on_resume_btn_pressed():
	if not settings_on:
		pause_trigger()

func _on_setting_btn_pressed():
	settings_on = true
	$CanvasLayer/MenuContainer.hide()
	$CanvasLayer/Settings.show()

func _on_settings_exit_settings():
	settings_on = false
	$CanvasLayer/MenuContainer.show()
	$CanvasLayer/Settings.hide()

func _on_quit_pressed():
	get_tree().quit()
