extends Node2D  # Parent node

# Signal
signal creature_killed 

# Creature settings
var is_walking: bool = false
var is_attacking: bool = false
var is_facing_down: bool = false

# Creature ressources
var health = 10 #eg

# Controls for creature assets
@onready var timer = $Timer
@onready var timer2 = $SoundTimer
# Creature assets



func _ready():
	pass
	
		
func _process(delta):
	if is_attacking:
		if $AnimatedSprite2D.animation != "attack":
			$AnimatedSprite2D.play("attack")
	elif is_walking:
		if is_facing_down == false:
			$AnimatedSprite2D.play("walk_up")
		else:
			$AnimatedSprite2D.play("walk_down")
		# Handle movement logic here
	else:
		if is_facing_down == false:
			$AnimatedSprite2D.play("idle_up")
		else:
			$AnimatedSprite2D.play("idle_down")
			
	if Input.is_action_pressed("B"):
		attack()
		#$AudioStreamPlayer2D.play()

#func initialize(position: Vector2):
	#$AnimatedSprite2D.frame.position = position

func attack():
	is_attacking = true
	$AnimatedSprite2D.play("attack")
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	timer.start()
	await timer.timeout
	$AudioStreamPlayer2D.play()
	$AnimatedSprite2D.hide()
	timer2.start()
	await timer2.timeout
	SignalManager._on_creature_killed(self)
	
func take_damage(damage: int):
	health -= damage
	if health <= 0:
		SignalManager._on_creature_killed(self) #attack
		
# Example function to handle a collision
func _on_body_entered(body):
	# Respond to collision with another body (e.g., another creature or player)
	print("Collision detected with: ", body.name)

	
