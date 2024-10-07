extends Node2D

@onready var is_paused := false
@onready var settings_on := false

@onready var mob = preload("res://scenes/test_mob.tscn")
@onready var building = preload("res://scenes/test_building.tscn")

@onready var building_container = $BuildingContainer
@onready var mob_id := 0
@onready var building_id := 0
@onready var building_slots := [true, true, true, true, true, true, true, true, true, true, true]

@onready var game_music = $GameMusic
@onready var end_menu = $CanvasLayer/EndMenu
@onready var map = $SingleLane
@onready var creature_container = $CreatureContainer
@onready var menu = $CanvasLayer/MenuContainer
@onready var settings = $CanvasLayer/Settings

func _ready():
	menu.hide()
	settings.hide()
	game_music.play()

func _process(_delta):
	if Input.is_action_just_pressed("esc") && not settings_on:
		pause_trigger()

func pause_trigger():
	if (is_paused):
		menu.hide()
		$CanvasLayer/PauseBtn.show()
		is_paused = false
		Engine.time_scale = 1
	else:
		menu.show()
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
	menu.hide()
	settings.show()

func _on_settings_exit_settings():
	settings_on = false
	menu.show()
	settings.hide()

func _on_quit_pressed():
	get_tree().quit()

func _on_creature_spawn_timer_timeout():
	if (mob_id < 6):
		_spawn_creature(true)
		_spawn_creature(false)
		_spawn_building(true)
		_spawn_building(false)
	
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

func _spawn_building(_is_player_mob):
	var new_building = building.instantiate()
	building_container.add_child(new_building)
	new_building.id = building_id
	building_id += 1
	if _is_player_mob:
		for i in 3:
			if building_slots[i]:
				#Check if player can build there
				new_building.position = map.building_slots[i].position
				new_building.is_player_mob = true
				building_slots[i] = false
				return
		print("Player can't build")
		return
	for i in range(10, 7, -1):
		if building_slots[i]:
			#check if ai can build there
			new_building.position = map.building_slots[i].position
			new_building.is_player_mob = false
			building_slots[i] = false
			return
	print("AI can't build")

func _on_card_ui_card_effect(_card):
	print("has been played: ", _card.title)

func _on_lose_btn_pressed():
	menu.hide()
	end_menu.end_msg.text = "You've lost, nub"
	end_menu.retry_btn.text = "Try again"
	end_menu.show()

func _on_win_btn_pressed():
	menu.hide()
	end_menu.end_msg.text = "Victory!"
	end_menu.retry_btn.text = "Next level"
	end_menu.victory = true
	end_menu.show()
