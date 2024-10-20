extends Node2D

@onready var projectile = preload("res://scenes/Other/projectile.tscn")
@onready var projectile_container = $ProjectileContainer

func _ready():
	pass # Replace with function body.

func _process(_delta):
	pass

func shoot(damage: int, target, texture):
	var new_projectile = projectile.instantiate()
	projectile_container.add_child(new_projectile)
	new_projectile.damage = damage
	new_projectile.set_target(target)
	new_projectile.target_touched.connect(_hit)
	if texture:
		new_projectile.sprite.texture = texture

func _hit(damage, target):
	if not is_instance_valid(target):
		return
	target.health -= damage
	if (target.health <= 0):
		target.queue_free()
