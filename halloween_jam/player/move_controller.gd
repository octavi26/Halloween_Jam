extends Node

# Return the desired direction of movement for the character
# in the range [-1, 1], where positive values indicate a desire
# to move to the right and negative values to the left.
func get_movement_directionx() -> float:
	return Input.get_axis("move_left", "move_right")
func get_movement_directiony() -> float:
	return Input.get_axis("move_up", "move_down")

# Return a boolean indicating if the character wants to dash
func wants_sprint() -> bool:
	return Input.is_action_pressed("sprint")
