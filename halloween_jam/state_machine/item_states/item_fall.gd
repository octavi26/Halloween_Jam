extends State

@export var idle_state: State
@export var jump_state: State

func process_physics(delta: float) -> State:
	var move_direction := signf(get_movement_input())
	parent.velocity.x = move_toward(parent.velocity.x, 
		move_direction * parent.jump_horizontal_speed, parent.air_acceleration * delta)
	sprite.flip_h = move_direction < 0.0
	
	parent.velocity.y += parent.fall_gravity * delta
	parent.velocity.y = minf(parent.velocity.y, parent.max_fall_speed)
	parent.move_and_slide()
	
	if get_jump():
		return jump_state

	if parent.is_on_floor():
		return idle_state
	
	return null
