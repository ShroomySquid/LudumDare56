extends Marker2D

@onready var inside_checkpoint = []
# 0 = neutral, nobody control the checkpoint; 1 = player; 2 = AI;
@onready var checkpoint_control = 0
@onready var player_light = $LightPlayer
@onready var ai_light = $LightAI
@onready var neutral_light = $LightNeutral
@export var checkpoint_id : int

signal update_checkpoint

func _ready():
	_update_light()

func _process(delta):
	pass

func check_control():
	var is_player_in = false
	var is_ai_in = false
	for i in inside_checkpoint:
		if i.is_player_mob == true && is_player_in == false:
			is_player_in = true
		if i.is_player_mob == false && is_ai_in == false:
			is_ai_in = true
		if checkpoint_control == 0 && is_player_in && is_ai_in:
			return ;
	if is_player_in && checkpoint_control != 1:
		checkpoint_control = 1
		_update_light()
		update_checkpoint.emit(checkpoint_control)
	if is_ai_in && checkpoint_control != 2:
		checkpoint_control = 2
		_update_light()
		update_checkpoint.emit(checkpoint_control)
	if is_ai_in && is_player_in && checkpoint_control != 0:
		checkpoint_control = 0
		_update_light()
		update_checkpoint.emit(checkpoint_control)

func _update_light():
	if checkpoint_control == 0:
		player_light.hide()
		ai_light.hide()
		neutral_light.show()
	elif checkpoint_control == 1:
		player_light.show()
		ai_light.hide()
		neutral_light.hide()
	if checkpoint_control == 2:
		player_light.hide()
		ai_light.show()
		neutral_light.hide()

func _on_area_2d_body_entered(body):
	if body.has_method("make_path"):
		inside_checkpoint.append(body)
		check_control()

func _on_area_2d_body_exited(body):
	if body.has_method("make_path"):
		inside_checkpoint.erase(body)
		check_control()
