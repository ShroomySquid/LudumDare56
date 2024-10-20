extends Camera2D

@onready var max_y_camera := 700
@onready var min_y_camera := -100
@onready var max_x_camera := 1000
@onready var min_x_camera := -100
var mouse_pos
const max_zoom := 0.5
const min_zoom := 10

func _ready():
	pass # Replace with function body.a

func _process(_delta):
	# Changing camera position with keyboard keys
	var direction = Input.get_vector("left", "right", "up", "down")
	if position.y > max_y_camera && direction.y > 0:
		direction.y = 0
	if position.y < min_y_camera && direction.y < 0:
		direction.y = 0
	if position.x > max_x_camera && direction.x > 0:
		direction.x = 0
	if position.x < min_x_camera && direction.x < 0:
		direction.x = 0
	position += (direction * 6) / zoom
	
	#Changin zoom
	if Input.is_action_just_pressed("WheelDown") && zoom.x < min_zoom:
		zoom *= 1.1
	if Input.is_action_just_pressed("WheelUp") && zoom.x > max_zoom:
		zoom *= 0.9
		
	#Changing camera position with click and drag
	if Input.is_action_just_pressed("RightClick"):
		mouse_pos = get_viewport().get_mouse_position()
	if Input.is_action_pressed("RightClick"):
		var new_mouse_pos = get_viewport().get_mouse_position()
		if (new_mouse_pos != mouse_pos):
			direction = mouse_pos - new_mouse_pos
			position += direction / zoom
			direction = direction.normalized()
			mouse_pos = new_mouse_pos
