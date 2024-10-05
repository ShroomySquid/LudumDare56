extends Node2D

enum CreatureType {CreatureA, CreatureB, CreatureC }

var CreatureScenes = {
	CreatureType.CreatureA: preload("res://scenes/Creatures/bob_omb.tscn")
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
