extends Node2D

@onready var card = preload("res://scenes/card.tscn")
@onready var position_decay := 0
@onready var spawn_point = $CanvasLayer/SpawnPoint

func _ready():
	pass # Replace with function body.

func _process(_delta):
	pass
	
func _on_generate_card_1_pressed():
	var new_card = card.instantiate()
	add_child(new_card)
	new_card.position = spawn_point.position
	new_card.position.x += position_decay
	position_decay += 100
	new_card.set_values(9, "Shibougamo", "Lieu perdu")

func _on_generate_card_2_pressed():
	var new_card = card.instantiate()
	add_child(new_card)
	new_card.position = spawn_point.position
	new_card.position.x += position_decay
	position_decay += 100
	new_card.set_values(5, "Saint-Ciboire", "Lieu encore plus perdu")
