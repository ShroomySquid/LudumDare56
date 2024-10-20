extends CharacterBody2D

@export var speed = 5000.0
@export var attack_range = 25
@export var health = 10
@export var damage = 2
@export var spawn_sound : AudioStream
@export var death_sound : AudioStream
@export var attack_sound : AudioStream

@onready var target: Node2D
@onready var ennemy_base: Node2D
@onready var nav_agent = $NavigationAgent2D
@onready var is_player_mob = true
@onready var attack_speed = $AttackTimer.wait_time
@onready var in_attack_range = false
@onready var shoot = $Shooting
@onready var random_sprite = $DefaultSprite.texture
var potential_targets = []
var id : int

#signal attack

func _ready():
	pass

func _physics_process(delta: float):
	is_ennemy_in_range()
	var immobolize = 1
	if in_attack_range:
		immobolize = 0
	else:
		immobolize = 1
	var direction = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = direction * speed * delta * immobolize
	move_and_slide()

func is_ennemy_in_range():
	if not is_instance_valid(target):
		in_attack_range = false
		return
	var distance = position.distance_to(target.position)
	if distance > attack_range:
		in_attack_range = false
	else:
		in_attack_range = true

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

func _on_attack_timer_timeout():
	if not in_attack_range or not is_instance_valid(target) or not target.has_method("make_path"):
		return
	if attack_range <= 25:
		target.take_hit(damage)
	else:
		shoot.shoot(damage, target, random_sprite)

func take_hit(damage_taken : int):
	health -= damage_taken
	if health <= 0:
		queue_free()
