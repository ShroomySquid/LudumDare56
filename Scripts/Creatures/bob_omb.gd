extends Node2D  # Parent node

var is_walking = false
var is_attacking = false



# Stats for the monster here


func _ready():
	pass
	
		
func _process(delta):
	if is_attacking:
		$AnimatedSprite2D.play("attacking")
	elif is_walking:
		$AnimatedSprite2D.play("walk")
		# Handle movement logic here
	else:
		$AnimatedSprite2D.play("idle")
		#$AudioStreamPlayer2D.play()

#func initialize(position: Vector2):
	#$AnimatedSprite2D.frame.position = position
	
# Example function to handle a collision
func _on_body_entered(body):
	# Respond to collision with another body (e.g., another creature or player)
	print("Collision detected with: ", body.name)
