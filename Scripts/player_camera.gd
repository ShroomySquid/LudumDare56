extends Camera2D

@onready var max_y_camera := 700
@onready var min_y_camera := -100
@onready var max_x_camera := 1000
@onready var min_x_camera := -100

func _ready():
	pass # Replace with function body.a

func _process(_delta):
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
	if Input.is_action_just_pressed("WheelDown"):
		zoom *= 1.1
	if Input.is_action_just_pressed("WheelUp"):
		zoom *= 0.9
