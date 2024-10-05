extends Node2D

@export var card_name := "yoyo"
@export var description := "rofl"
@export var cost := 1
@export var card_image: Node2D

@onready var cost_lbl = $ManaCost/ManaCostLbl
@onready var description_lbl = $CardDescription/DescriptionLbl
@onready var name_lbl = $Name/NameLbl

signal card_activated

var mouse_hover = false
var id = 0

func _ready():
	pass

func _activate():
	print("Entrypoint for card effect")

func set_values(_cost, _name, _description):
	card_name = _name
	description = _description
	cost = _cost
	cost_lbl.text = str(cost)
	description_lbl.text = description
	name_lbl.text = card_name
	
func set_id(_id):
	id = _id

func _process(_delta):
	if mouse_hover && scale.x < 1.1:
		await get_tree().create_timer(0.01).timeout
		scale += Vector2(0.02, 0.02)
	elif not mouse_hover && scale.x > 1:
		await get_tree().create_timer(0.01).timeout
		scale -= Vector2(0.02, 0.02)
	if Input.is_action_just_pressed("LeftClick") && mouse_hover:
		card_activated.emit(id)
		_activate()
		hide()

func _on_mouse_hover_mouse_entered():
	mouse_hover = true

func _on_mouse_hover_mouse_exited():
	mouse_hover = false
