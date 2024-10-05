extends Node2D

@onready var card = preload("res://scenes/card.tscn")
@onready var position_decay := 0
@onready var spawn_point = $SpawnPoint
@onready var hand = $CardContainer
@onready var hand_pos := 0
@onready var hand_size := 5

func _ready():
	for i in hand_size:
		await get_tree().create_timer(0.2).timeout
		create_card()

func create_card():
	var new_card = card.instantiate()
	hand.add_child(new_card)
	new_card.position = spawn_point.position
	new_card.position.x += position_decay
	position_decay += 200
	new_card.set_values(3, "Shibougamo", "Lieu perdu")
	new_card.set_hand_pos(hand_pos)
	hand_pos += 1
	new_card.card_activated.connect(_on_card_activated)

func _process(_delta):
	pass
	
func _on_card_activated(_hand_pos):
	var cards_in_hand = hand.get_children()
	for i in cards_in_hand:
		if i.hand_pos == _hand_pos:
			var potential_cards = GlobalControl.cards_prototype.get_children()
			var random_card = randi() % potential_cards.size()
			var new_card = potential_cards[random_card]
			i.set_values(new_card.cost, new_card.title, new_card.description)
			await get_tree().create_timer(0.5).timeout
			i.show()
