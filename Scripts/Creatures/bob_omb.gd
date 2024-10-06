extends Node2D  # Parent node

# Signal
signal creature_killed 
signal deals_damage

# Creature settings
var is_walking: bool = false
var is_attacking: bool = false
var is_facing_down: bool = false
var is_ennemy: bool = false

# Creature ressources
@onready var card_stats = GlobalControl.cards_prototype.get_children()[3]

@onready var health = card_stats.health

var entities_collision: Array = []

# Controls for creature assets
@onready var timer = $Timer
@onready var timer2 = $SoundTimer
@onready var bar = $ProgressBar
@onready var label = $RichTextLabel



func _ready():
	if is_ennemy == true:
		$AnimatedSprite2D.set_deffered("flip_h", false)
		
	# Setup for healthbar
	bar.max_value = health
	bar.value = health
	label.text = card_stats.title
	#label.bbcode_enabled = true

	#print("health: ", card_stats.health)
	pass
	
		
func _process(delta):
	if is_attacking:
		if $AnimatedSprite2D.frame == 1:
			$AnimatedSprite2D.scale = Vector2(2, 2)
		#if $AnimatedSprite2D.animation != "attack":
			#$AnimatedSprite2D.play("attack")
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
	#if $DamageArea/DamageCollision. #TODO make this
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
	label.hide()
	bar.hide()
	timer2.start()
	await timer2.timeout
	SignalManager._on_creature_killed(self)
	
func take_damage(damage: int):
	health -= damage
	update_health()
	if health <= 0:
		SignalManager._on_creature_killed(self) #attack
		
	
	
func update_health():
	bar.value = health
	#var health_ratio = float(health) / float(card_stats.health) 
	#var colored_text = "[color=green]" + str(health) + "[/color] / [color=red]" + str(card_stats.health) + "[/color]"
	#label.bbcode_text = colored_text
	
# Example function to handle a collision
func _on_body_entered(body):
	# Respond to collision with another body (e.g., another creature or player)
	print("Collision detected with: ", body.name)

	
