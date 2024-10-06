extends Node2D

@onready var is_paused := false
@onready var settings_on := false
@onready var mob = preload("res://scenes/test_mob.tscn")
@onready var map = $SingleLane
@onready var creature_container = $CreatureContainer
@onready var mob_id := 0

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

func _on_creature_spawn_timer_timeout():
	if (mob_id < 6):
		_spawn_creature(true)
		_spawn_creature(false)
	
func _spawn_creature(_is_player_mob):
	var new_mob = mob.instantiate()
	creature_container.add_child(new_mob)
	new_mob.id = mob_id
	mob_id += 1
	if _is_player_mob:
		new_mob.position = map.player_spawn_point.position
		new_mob.ennemy_base = map.ai_spawn_point
		new_mob.target = map.ai_spawn_point
		new_mob.is_player_mob = true
	else: 
		new_mob.position = map.ai_spawn_point.position
		new_mob.ennemy_base = map.player_spawn_point
		new_mob.target = map.player_spawn_point
		new_mob.is_player_mob = false
	new_mob.make_path()

func _on_card_ui_card_effect(_card):
	print("has been played: ", _card.title)
