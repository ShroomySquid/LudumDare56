extends Node2D

@onready var cost_lbl = $ManaCost/ManaCostLbl
@onready var description_lbl = $CardDescription/DescriptionLbl
@onready var name_lbl = $Name/NameLbl
@onready var image = $Image
@onready var card = Node2D
@onready var flip_btn = $FlipBtn
@onready var in_deck_editor := false

signal card_activated

var mouse_hover = false
var hand_pos = 0

func _ready():
	var image_texture = load("res://Images/TestImages/3web.png") #testimage
	image.texture = image_texture
	pass

func set_values(_card):
	card = _card
	
	
	
	cost_lbl.text = str(_card.cost)
	description_lbl.text = _card.description
	name_lbl.text = _card.title
	if _card.texture:
		image.texture = _card.texture
	if card.flip_index != -1:
		flip_btn.show()
	else:
		flip_btn.hide()
		
	
func set_hand_pos(_hand_pos):
	hand_pos = _hand_pos

func _process(_delta):
	if mouse_hover && scale.x < 1.1 && Engine.time_scale != 0:
		await get_tree().create_timer(0.01).timeout
		if not in_deck_editor:
			position.y -= 15
		scale += Vector2(0.02, 0.02)
	elif not mouse_hover && scale.x > 1:
		await get_tree().create_timer(0.01).timeout
		if not in_deck_editor:
			position.y += 15
		scale -= Vector2(0.02, 0.02)
	if Input.is_action_just_pressed("LeftClick") && mouse_hover && Engine.time_scale != 0:
		card_activated.emit(hand_pos)

func _on_mouse_hover_mouse_entered():
	# TODO: Change to account for card overlap
	mouse_hover = true

func _on_mouse_hover_mouse_exited():
	# TODO: Change to account for card overlap
	mouse_hover = false

func _on_flip_btn_pressed():
	set_values(GlobalControl.cards_prototype.get_children()[card.flip_index])
