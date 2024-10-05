extends Node2D

@export var card_name := "yoyo"
@export var description := "rofl"
@export var cost := 1
@export var card_image: Node2D

@onready var cost_lbl = $ManaCost/ManaCostLbl
@onready var description_lbl = $CardDescription/DescriptionLbl
@onready var name_lbl = $Name/NameLbl


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
	pass
