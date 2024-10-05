extends Node2D  # Parent node

var is_walking = false

func _ready():
	$AnimatedSprite2D.play("idle")  # Start with idle animation

func _process(delta):
	if is_walking:
		$AnimatedSprite2D.play("walk")
		# Handle movement logic here
	else:
		$AnimatedSprite2D.play("idle")

# Example function to handle a collision
func _on_body_entered(body):
	# Respond to collision with another body (e.g., another creature or player)
	print("Collision detected with: ", body.name)
