extends CharacterBody2D

const SPEED = 6000.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta):
	#z_index = position.y
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED * delta
	move_and_slide()
