extends Node2D

@onready var unit = preload("res://scenes/unit.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var new_unit = unit.instantiate()
	add_child(new_unit)
	new_unit.load("Fire_fists")
	new_unit.position = Vector2(100, 100)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
