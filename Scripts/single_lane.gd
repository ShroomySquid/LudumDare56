extends TileMapLayer

@onready var player_spawn_point = $PlayerSpawnPoint
@onready var ai_spawn_point = $AISpawnPoint
@onready var building_slots = [$BuildingSlot1, $BuildingSlot2, $BuildingSlot3, $BuildingSlot4, $BuildingSlot5, $BuildingSlot6, $BuildingSlot7, $BuildingSlot8, $BuildingSlot9, $BuildingSlot10, $BuildingSlot11]

func _ready():
	pass # Replace with function body.

func _process(_delta):
	pass
