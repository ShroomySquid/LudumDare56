extends ResourcePreloader

@export var title : String
@export var attack : int
@export var health : int
@export var attack_range : int
@export var cost : int
@export var type := Type.CREATURE
@export var faction := Faction.GOBELINS
@export var texture: Texture
@export var id: int
@export var description: String
@export var flip_index := -1

enum Type {
	CREATURE,
	BUILDING,
	PROGRAM,
}
enum Faction {
	GOBELINS,
	ALIENS,
	NEUTRE,
}

func _ready():
	pass # Replace with function body.

func _process(_delta):
	pass
