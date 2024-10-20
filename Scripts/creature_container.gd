extends Node2D

# Setup for positions where to spawn on SingleLane
#@onready var player_spawn_point = SingleLane.PlayerSpawnPoint #TODO fix this
#@onready var ai_spawn_point = SingleLane.ai_spawn_point
var player_spawn_point
var ai_spawn_point

enum CreatureType {CreatureA, CreatureB, CreatureC }

# Creature assets
var creature_scenes = [
	preload("res://scenes/Creatures/bob_omb.tscn"),
	preload("res://scenes/Creatures/fire_fist.tscn"),
	preload("res://scenes/Creatures/retriever.tscn"),
	preload("res://scenes/Creatures/Goblin_slinger.tscn")
	#preload("res://scenes/Creatures/"),
]


# Creatures in queue
#var summoned_creatures = []
#var nb_units: int = 0
@onready var template = preload("res://scenes/Creatures/Template_unit.tscn")
var template_instance
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.connect("creature_killed", Callable(self,"_on_creature_killed"))
	template_instance = template.instantiate()
	add_child(template_instance)
	pass # Replace with function body.
	
@onready var card_list = GlobalControl.cards_prototype.get_children()
func _on_card_played(_card, player: bool):
	var spawn_position #TODO will have to modify to account for buildings
	if player == true:
		spawn_position = player_spawn_point#SingleLane.player_spawn_point
	else:
		spawn_position = ai_spawn_point#SingleLane.ai_spawn_point
	var id = _card.id
	#if id >= 0 and id < card_list.size():
	for i in range(_card.health):
		spawn_creature(_card.type, spawn_position)
	#if id >= 0 and id < card_list.size():
	#	for i in range(card_list[id].health): #TODO change to proper var when added
	#		spawn_creature(card_list[id].type, spawn_position)
	#else:
	#	print("Invalid id: ", id)
	
		
# Function to spawn a creature
func spawn_creature(creature_type: CreatureType, _position: Vector2):	
	if	creature_type in creature_scenes:	
		var creature_instance = creature_scenes[creature_type].instantiate()
		add_child(creature_instance)
		
		#Set position of the creature relative to map
		creature_instance.position = _position
		
		# Add the creature to the array
		#summoned_creatures.append(creature_instance)
		return creature_instance
	#else:
	#	print("Creature type not found: ", _card.type)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("M"):	
		spawn_creature(CreatureType.CreatureA, position) #TODO: change to position of base
	#nb_units = summoned_creatures.size()
	pass
	
func set_positions(player_position: Vector2, ai_position: Vector2):
	player_spawn_point = player_position
	ai_spawn_point = ai_position
	
func _on_creature_killed(creature_instance):
	#summoned_creatures.remove(creature_instance) #Not sure why this wont work but queue_free does
	creature_instance.queue_free()
	#print("Units on map: ", nb_units)
	#print("Creature killed and removed from tracking.") #DEBUG
  
func _on_card_ui_card_effect(_card) -> void:
	_on_card_played(_card, true)
	pass # Replace with function body.
