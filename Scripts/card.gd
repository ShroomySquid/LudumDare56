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


func _ready():
	set_values(cost, card_name, description)

func set_values(_cost, _name, _description):
	card_name = _name
	description = _description
	cost = _cost
	cost_lbl.text = str(cost)
	description_lbl.text = description
	name_lbl.text = card_name

func _process(_delta):
	if mouse_hover:
		scale = Vector2(1.2, 1.2)
	else:
		scale = Vector2(1, 1)
	if Input.is_action_just_pressed("LeftClick") && mouse_hover:
		print("clicked")
		card_activated.emit()

func _on_mouse_hover_mouse_entered():
	mouse_hover = true

func _on_mouse_hover_mouse_exited():
	mouse_hover = false