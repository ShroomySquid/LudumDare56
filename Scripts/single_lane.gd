extends TileMapLayer

@onready var player_spawn_point = $PlayerSpawnPoint
@onready var ai_spawn_point = $AISpawnPoint
@onready var building_slots = [$BuildingSlot1, $BuildingSlot2, $BuildingSlot3, $BuildingSlot4, $BuildingSlot5, $BuildingSlot6, $BuildingSlot7, $BuildingSlot8, $BuildingSlot9, $BuildingSlot10, $BuildingSlot11]

@onready var checkpoint_container = $CheckpointContainer
func _ready():
	pass # Replace with function body.

func _process(_delta):
	pass

func _on_checkpoint_update_checkpoint(_checkpoint_control):
	print("checkpoint 1 now has value: ", _checkpoint_control)

func _on_checkpoint_2_update_checkpoint(_checkpoint_control):
	print("checkpoint 2 now has value: ", _checkpoint_control)

func _on_checkpoint_3_update_checkpoint(_checkpoint_control):
	print("checkpoint 3 now has value: ", _checkpoint_control)

func _on_checkpoint_4_update_checkpoint(_checkpoint_control):
	print("checkpoint 4 now has value: ", _checkpoint_control)

func _on_checkpoint_5_update_checkpoint(_checkpoint_control):
	print("checkpoint 5 now has value: ", _checkpoint_control)
