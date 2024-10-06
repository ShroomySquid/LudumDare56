extends Node

# Define signals that different scenes can emit
signal creature_killed

# Send back signal
func _on_creature_killed(target: Node2D):
	emit_signal("creature_killed", target)
