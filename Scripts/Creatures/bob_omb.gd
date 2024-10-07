extends Node2D  # Parent node

# Signal
signal creature_killed 
signal deals_damage

# Creature settings
var is_walking: bool = false
var is_attacking: bool = false
var is_facing_down: bool = false
var is_ennemy: bool = false


# Unique vars
var heating: int = 0

# Creature ressources
@onready var card_stats = GlobalControl.cards_prototype.get_children()[0]

@onready var health = card_stats.health

var entities_collision: Array = []

# Controls for creature assets
@onready var bar = $ProgressBar
@onready var label = $RichTextLabel



func _ready():
	if is_ennemy == true:
		$AnimatedSprite2D.set_deffered("flip_h", false)
		
	# Setup for healthbar
	bar.max_value = health
	bar.value = health
	label.text = card_stats.title
	
	#green code: 008f00
	#red code: e30000
	#var style_fg = StyleBoxFlat.new()
	#style_fg.bg_color = Color(1, 0, 0)  # Set color to red
	#var style_bg = StyleBoxFlat.new()
	#style_bg.bg_color = Color(0.5, 0.5, 0.5)  # Set color to gray
	#bar.theme_stylebox_override("fg", style_fg)  # Foreground (filled part)
	#bar.theme_stylebox_override("bg", style_bg)  # Background (empty part)
	#label.bbcode_enabled = true
	#bar.set_modulate(Color.DARK_RED)
	
	#print("health: ", card_stats.health)
	pass
	
		
func _process(_delta):
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
			

func attack():
	is_attacking = true
	$AnimatedSprite2D.play("attack")
	
	
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

	
