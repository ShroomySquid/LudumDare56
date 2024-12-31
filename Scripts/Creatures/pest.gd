extends Unit

func _ready():
	s_load("Pests")
	health = 6
	damage = 1

func take_hit(damage_taken : int):
	print("Taking ", damage_taken, " damage and I am a Pest")
	health -= damage_taken
	if health <= 0:
		queue_free()
