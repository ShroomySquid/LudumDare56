extends Node2D

@onready var is_paused := false
@onready var top_map := $TileMapLayer
@onready var current_cells = top_map.get_used_cells()

func _ready():
	$CanvasLayer/MenuContainer.hide()
	$CanvasLayer/Settings.hide()

func _process(_delta):
	if Input.is_action_just_pressed("esc"):
		pause_trigger()
	if Input.is_action_just_pressed("LeftClick"):
		var mouse_pos = top_map.local_to_map(get_global_mouse_position())
		if not current_cells.has(mouse_pos):
			current_cells.append(mouse_pos)
			top_map.set_cell(mouse_pos, 1, Vector2i(2, 0), 0)
	if Input.is_action_just_pressed("RightClick"):
		var mouse_pos = top_map.local_to_map(get_global_mouse_position())
		if current_cells.has(mouse_pos):
			current_cells.erase(mouse_pos)
			top_map.set_cell(mouse_pos, -1, Vector2i(2, 0), 0)

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
	
	
