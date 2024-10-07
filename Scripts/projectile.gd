extends CharacterBody2D

const SPEED = 12000.0

@onready var nav_agent = $NavigationAgent2D
@onready var damage := 1
@onready var target = Node2D

signal target_touched

func _ready():
	pass

func _physics_process(delta):	
	var direction = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = direction * SPEED * delta
	move_and_slide()

func set_target(new_target):
	target = new_target
	nav_agent.target_position = new_target.global_position

func _on_touch_area_body_entered(body):
	if body == target:
		target_touched.emit(damage, target)
		queue_free()

func _on_path_timer_timeout():
	nav_agent.target_position = target.global_position
