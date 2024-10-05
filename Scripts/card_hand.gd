extends Node2D

@onready var card = preload("res://scenes/card.tscn")
@onready var position_decay := 0
@onready var spawn_point = $SpawnPoint
@onready var hand = $CardHand
@onready var hand_pos := 0
@onready var hand_size := 5
@onready var deck = []
@onready var deck_size := 20
@onready var discard_pile = []

func _ready():
	fill_deck()
	for i in hand_size:
		await get_tree().create_timer(0.2).timeout
		create_card()

func fill_deck():
	for i in deck_size:
		var potential_cards = GlobalControl.cards_prototype.get_children()
		var random_card = randi() % potential_cards.size()
		deck.append(random_card)

func create_card():
	var new_card = card.instantiate()
	hand.add_child(new_card)
	new_card.position = spawn_point.position
	new_card.position.x += position_decay
	position_decay += 200
	new_card.hand_pos = hand_pos
	hand_pos += 1
	render_card(new_card)
	new_card.card_activated.connect(_on_card_activated)

func _process(_delta):
	pass
	
func _on_card_activated(_hand_pos):
	var cards_in_hand = hand.get_children()
	for i in cards_in_hand:
		if i.hand_pos == _hand_pos:
			render_card(i)

func render_card(card):
	var top_card = GlobalControl.cards_prototype.get_children()[deck[0]]
	card.set_values(top_card.cost, top_card.title, top_card.description, top_card.texture)
	await get_tree().create_timer(0.5).timeout
	card.show()
	discard_pile.append(deck[0])
	deck.remove_at(0)
	if not deck.size():
		reshuffle()

func reshuffle():
	deck = discard_pile
	deck.shuffle()
	discard_pile = []
