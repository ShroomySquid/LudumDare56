extends Node2D

@onready var cost_lbl = $ManaCost/ManaCostLbl
@onready var description_lbl = $CardDescription/DescriptionLbl
@onready var name_lbl = $Name/NameLbl
@onready var image = $Image
@onready var id = -1

signal card_activated

var mouse_hover = false
var hand_pos = 0

func _ready():
	pass

func _activate():
	print("Entrypoint for card effect")

func set_values(_cost, _name, _description, _texture, _id):
	id = _id
	cost_lbl.text = str(_cost)
	description_lbl.text = _description
	name_lbl.text = _name
	if _texture:
		image.texture = _texture
	
func set_hand_pos(_hand_pos):
	hand_pos = _hand_pos

func _process(_delta):
	if mouse_hover && scale.x < 1.1:
		await get_tree().create_timer(0.01).timeout
		scale += Vector2(0.02, 0.02)
	elif not mouse_hover && scale.x > 1:
		await get_tree().create_timer(0.01).timeout
		scale -= Vector2(0.02, 0.02)
	if Input.is_action_just_pressed("LeftClick") && mouse_hover:
		print("hello")
		card_activated.emit(hand_pos)
		_activate()
		hide()

func _on_mouse_hover_mouse_entered():
	mouse_hover = true

func _on_mouse_hover_mouse_exited():
	mouse_hover = false
