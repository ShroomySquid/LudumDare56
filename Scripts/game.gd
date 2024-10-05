extends Node2D

@onready var is_paused := false

func _ready():
	$CanvasLayer/MenuContainer.hide()
	$CanvasLayer/Settings.hide()

func _process(_delta):
	if Input.is_action_just_pressed("esc"):
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
		pause_trigger()

func _on_resume_btn_pressed():
		pause_trigger()

func _on_setting_btn_pressed():
	$CanvasLayer/MenuContainer.hide()
	$CanvasLayer/Settings.show()

func _on_settings_exit_settings():
	$CanvasLayer/MenuContainer.show()
	$CanvasLayer/Settings.hide()
	
	
