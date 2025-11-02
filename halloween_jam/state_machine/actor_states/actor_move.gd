extends State

@export var idle_state: State

func process_physics(delta: float) -> State:
	var move_direction_x := signf(get_movement_inputx())
	if absf(move_direction_x) > 0.0:
		if get_sprint():
			parent.velocity.x = move_toward(parent.velocity.x, 
				move_direction_x * parent.max_sprint_speed, parent.move_acceleration * delta)	
			
		else:
			parent.velocity.x = move_toward(parent.velocity.x, 
				move_direction_x * parent.max_move_speed, parent.move_acceleration * delta)
#w			sprite.flip_h = move_direction_x < 0.0
			
	var move_direction_y := signf(get_movement_inputy())
	if absf(move_direction_y) > 0.0:
		if get_sprint():
			parent.velocity.y = move_toward(parent.velocity.y, 
				move_direction_y * parent.max_sprint_speed, parent.move_acceleration * delta)	
			
		else:
			parent.velocity.y = move_toward(parent.velocity.y, 
				move_direction_y * parent.max_move_speed, parent.move_acceleration * delta)
			#sprite.flip_h = move_direction_y < 0.0

	parent.move_and_slide()
	

	if move_direction_x == 0.0 and move_direction_y == 0.0:
		return idle_state
	
	return null
