extends Node2D

@onready var card_node = preload("res://scenes/card.tscn")
@onready var position_decay := 0
@onready var spawn_point = $SpawnPoint
@onready var card_list = GlobalControl.cards_prototype.get_children()

@onready var hand = $CardHand
@onready var hand_pos := 0
@onready var hand_size := 4

@onready var deck = []
@onready var deck_size := 10
@onready var discard_pile = []
@onready var cards_left = $Deck.cards_left
@onready var cards_in_discard = $DiscardPile.cards_in_discard

@onready var current_mana = 0
@onready var max_mana = 10
@onready var current_mana_lbl = $Mana.current_mana
@onready var restore_mana_ready = true
@onready var mana_reg_in_sec = 1.0

@onready var starter_deck = []

signal card_effect

func _ready():
	fill_deck()
	cards_left.text = str(deck.size())
	cards_in_discard.text = str(discard_pile.size())
	for i in hand_size:
		await get_tree().create_timer(0.2).timeout
		create_card()

func fill_deck():
	
	starter_deck.append_array(GlobalControl.deck)
	deck.append_array(starter_deck)
	deck.shuffle()

func create_card():
	var new_card = card_node.instantiate()
	hand.add_child(new_card)
	new_card.position = spawn_point.position
	new_card.position.x += position_decay
	position_decay += 175
	new_card.hand_pos = hand_pos
	hand_pos += 1
	render_card(new_card, false)
	new_card.card_activated.connect(_on_card_activated)

func _process(_delta):
	if restore_mana_ready:
		_restore_mana()

func _restore_mana():
	_update_mana(1)
	restore_mana_ready = false
	await get_tree().create_timer(mana_reg_in_sec).timeout
	restore_mana_ready = true

func _update_mana(value):
	current_mana += value
	if (current_mana > 10):
		current_mana = 10
	current_mana_lbl.text = str(current_mana) + " / " + str(max_mana)
	
func _on_card_activated(_hand_pos):
	var cards_in_hand = hand.get_children()
	for i in cards_in_hand:
		if i.hand_pos == _hand_pos:
			if i.card.cost <= current_mana:
				i.hide()
				_update_mana(i.card.cost * -1)
				card_effect.emit(i.card)
				render_card(i, true)
			else:
				print("cannot play card")

func render_card(card, to_discard):
	if to_discard:
		discard_pile.append(card.card.id)
	var top_card = card_list[deck[0]]
	card.set_values(top_card)
	deck.remove_at(0)
	await get_tree().create_timer(0.5).timeout
	card.show()
	if not deck.size():
		reshuffle()
	cards_left.text = str(deck.size())
	cards_in_discard.text = str(discard_pile.size())

func reshuffle():
	deck = discard_pile
	deck.shuffle()
	discard_pile = []
