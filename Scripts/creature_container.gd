extends Node2D

enum CreatureType {CreatureA, CreatureB, CreatureC }

var creature_scenes = {
	CreatureType.CreatureA: preload("res://scenes/Creatures/bob_omb.tscn")
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Function to spawn a creature
func spawn_creature(creature_type: CreatureType, position: Vector2):	
	if	creature_type in creature_scenes:	
		var creature_instance = creature_scenes[creature_type].instantiate()
		add_child(creature_instance)
		print("Requested before position: ", position)# DEBUG
		print("Position before of creature: ", creature_instance.position)# DEBUG
		creature_instance.position = position
		#creature_instance.AnimatedSprite2D.frame.position = position
		print("Requested after position: ", position)# DEBUG
		print("Position after of creature: ", creature_instance.position)# DEBUG
		
		print("Creature type summoned: ", creature_type)# DEBUG
		return creature_instance
	else:
		print("Creature type not found: ", creature_type)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("down"):	
		spawn_creature(CreatureType.CreatureA, Vector2(6, 72)) #TODO: change to position of base
	if Input.is_action_pressed("B"):
		self.position += Vector2(10, 0)
	pass
