extends CharacterBody2D

@onready var target: Node2D
@onready var is_player_mob = true
@onready var attack_range = 100
var potential_targets = []
var id : int

func _ready():
	pass

func is_ennemy_in_range():
	return target != null

func _on_line_of_sight_body_entered(body):
	if body.is_player_mob != is_player_mob:
		potential_targets.append(body)

func _on_line_of_sight_body_exited(body):
	if body.is_player_mob != is_player_mob:
		potential_targets.erase(body)

func _on_check_target_timeout():
	if potential_targets.size() > 0:
		target = potential_targets[0]
	else:
		target = null
