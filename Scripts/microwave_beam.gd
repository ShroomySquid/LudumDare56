extends Node2D

@onready var targets = []

func _ready():
	pass # Replace with function body.

func _process(_delta):
	global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("LeftClick"):
		for i in targets:
			#i.heat += 3
			pass
		queue_free()

func _on_beam_area_body_entered(body):
	if not body.has_method("make_path"):
		return
	targets.append(body)

func _on_beam_area_body_exited(body):
	if not body.has_method("make_path"):
		return
	targets.erase(body)
