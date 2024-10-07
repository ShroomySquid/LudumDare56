extends Node2D

@onready var projectile = preload("res://scenes/projectile.tscn")
@onready var projectile_container = $ProjectileContainer

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func shoot(damage: int, target):
	var new_projectile = projectile.instantiate()
	projectile.add_child(new_projectile)
	new_projectile.damage = damage
	new_projectile.set_target(target)
	new_projectile.target_touched.connect(_hit)

func _hit(damage, target):
	#target.hp -= damage
	print("yo")
