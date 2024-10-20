extends Node2D

@onready var card_node = preload("res://scenes/card.tscn")
@onready var start = $Start
@onready var position_decay := 0
@onready var card_list = GlobalControl.cards_prototype.get_children()
@onready var mode = 0


@onready var deck = [24, 24, 24, 24, 20, 20, 2, 2, 25, 25]
@onready var booster = [15, 16, 17, 18]
@onready var selected = 0

#signal edit_done

func _render_deck():
	for i in deck.size():
		create_card(i, deck)

func _render_booster():
	for i in booster.size():
		create_card(i, booster)

func blank():
	position_decay = 0
	for child in $CardContainer.get_children():
		child.queue_free()

func switch():
	blank()
	if !mode:
		_render_booster()
		mode = 1
	else:
		_render_deck()
		mode = 0


func create_card(i: int, pile):
	var new_card = card_node.instantiate()
	$CardContainer.add_child(new_card)
	new_card.in_deck_editor = true
	new_card.position = start.position
	new_card.position.x += position_decay
	position_decay += 175
	if i == 4:
		position_decay = 0
	if i > 4: 
		new_card.position.y += 275
	new_card.hand_pos = i
	var top_card = card_list[pile[i]]
	new_card.set_values(top_card)
	new_card.card_activated.connect(_on_card_activated)

func _on_card_activated(hand_pos):
	if mode:
		selected = booster[hand_pos]
		booster.remove_at(hand_pos)
	else:
		deck[hand_pos] = selected
		get_tree().change_scene_to_file("res://scenes/game.tscn")
		return
	switch()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	deck = GlobalControl.deck
	deck.sort()
	booster = []
	for i in 5:
		booster.append(randi_range(0, 29))
	switch()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
