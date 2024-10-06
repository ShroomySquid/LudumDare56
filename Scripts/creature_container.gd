extends Node2D

enum CreatureType {CreatureA, CreatureB, CreatureC }

# Creature assets
var creature_scenes = {
	CreatureType.CreatureA: preload("res://scenes/Creatures/bob_omb.tscn")
}

# Creatures in queue
var summoned_creatures = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.connect("creature_killed", Callable(self,"_on_creature_killed"))
	pass # Replace with function body.

# Function to spawn a creature
func spawn_creature(creature_type: CreatureType, position: Vector2):	
	if	creature_type in creature_scenes:	
		var creature_instance = creature_scenes[creature_type].instantiate()
		add_child(creature_instance)
		
		#Set position of the creature relative to map
		creature_instance.position = position
		
		# Add the creature to the array
		summoned_creatures.append(creature_instance)
		
		return creature_instance
	else:
		print("Creature type not found: ", creature_type)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("M"):	
		spawn_creature(CreatureType.CreatureA, Vector2(200, 500)) #TODO: change to position of base
	pass
	
func _on_creature_killed(creature_instance):
	creature_instance.queue_free()
	#summoned_creatures.erased(creature_instance) #Not sure why this wont work but queue_free does
	#print("Creature killed and removed from tracking.") #DEBUG
