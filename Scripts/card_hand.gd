extends Node2D

@onready var card = preload("res://scenes/card.tscn")
@onready var position_decay := 0
@onready var spawn_point = $SpawnPoint
@onready var hand = $CardContainer
@onready var id := 0
@onready var hand_size := 5

func _ready():
	for i in hand_size:
		create_card()

func create_card():
	var new_card = card.instantiate()
	hand.add_child(new_card)
	new_card.position = spawn_point.position
	new_card.position.x += position_decay
	position_decay += 200
	new_card.set_values(3 + id, "Shibougamo", "Lieu perdu")
	new_card.set_id(id)
	id += 1
	new_card.card_activated.connect(_on_card_activated)

func _process(_delta):
	pass
	
func _on_card_activated(_id):
	var cards_in_hand = hand.get_children()
	for i in cards_in_hand:
		if i.id == _id:
			i.set_values(1, "patate", "chocolat")
			await get_tree().create_timer(0.5).timeout
			i.show()

func _on_generate_card_1_pressed():
	var new_card = card.instantiate()
	add_child(new_card)
	new_card.position = spawn_point.position
	new_card.position.x += position_decay
	position_decay += 100
	new_card.set_values(9, "Shibougamo", "Lieu perdu")
	new_card.card_activated.connect(_on_card_activated)
