extends Node2D

# Setup for positions where to spawn on SingleLane
@onready var player_spawn_point = $PlayerSpawnPoint
@onready var ai_spawn_point = $AISpawnPoint

enum CreatureType {CreatureA, CreatureB, CreatureC }

# Creature assets
var creature_scenes = {
	CreatureType.CreatureA: preload("res://scenes/Creatures/bob_omb.tscn")

}

# Creatures in queue
#var summoned_creatures = []
#var nb_units: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.connect("creature_killed", Callable(self,"_on_creature_killed"))
	pass # Replace with function body.

@onready var card_list = GlobalControl.cards_prototype.get_children()
func _on_card_played(id: int, player: bool):
	var spawn_position #TODO will have to modify to account for buildings
	if player == true:
		spawn_position = player_spawn_point
	else:
		spawn_position = ai_spawn_point
		
	if id >= 0 and id < card_list.size():
		for i in range(card_list[id].health): #TODO change to proper var when added
			spawn_creature(card_list[id].type, spawn_position)
	else:
		print("Invalid id: ", id)
		
		
# Function to spawn a creature
func spawn_creature(creature_type: CreatureType, position: Vector2):	
	if	creature_type in creature_scenes:	
		var creature_instance = creature_scenes[creature_type].instantiate()
		add_child(creature_instance)
		
		#Set position of the creature relative to map
		creature_instance.position = position
		
		# Add the creature to the array
		#summoned_creatures.append(creature_instance)
		return creature_instance
	else:
		print("Creature type not found: ", creature_type)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("M"):	
		spawn_creature(CreatureType.CreatureA, Vector2(200, 500)) #TODO: change to position of base
	#nb_units = summoned_creatures.size()
	pass
	
func _on_creature_killed(creature_instance):
	#summoned_creatures.remove(creature_instance) #Not sure why this wont work but queue_free does
	creature_instance.queue_free()
	#print("Units on map: ", nb_units)
	#print("Creature killed and removed from tracking.") #DEBUG
