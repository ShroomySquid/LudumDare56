extends CharacterBody2D

var speed = 3000.0
@onready var target: Node2D
@onready var ennemy_base: Node2D
@onready var nav_agent = $NavigationAgent2D
@onready var is_player_mob = true
@onready var attack_range = 100
var potential_targets = []
var id : int

func _ready():
	pass

func _physics_process(delta: float):
	if is_ennemy_in_range():
		speed = 0.0
	else:
		speed = 3000.0
	var direction = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = direction * speed * delta
	move_and_slide()

func is_ennemy_in_range():
	if not is_instance_valid(target):
		return false
	var distance = position.distance_to(target.position)
	if distance > attack_range:
		return false
	return true

func make_path():
	nav_agent.target_position = target.global_position

func _on_line_of_sight_body_entered(body):
	if not body.has_method("make_path"):
		return
	if body.is_player_mob != is_player_mob:
		potential_targets.append(body)

func _on_line_of_sight_body_exited(body):
	if not body.has_method("make_path"):
		return
	if body.is_player_mob != is_player_mob:
		potential_targets.erase(body)

func _on_check_target_timeout():
	if potential_targets.size() > 0:
		target = potential_targets[0]
	else:
		target = ennemy_base
	make_path()
