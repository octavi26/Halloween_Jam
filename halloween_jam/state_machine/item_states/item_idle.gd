extends State

@export var fall_state: State
@export var jump_state: State

func process_physics(delta: float) -> State:
	parent.velocity.x = move_toward(parent.velocity.x, 0.0, parent.move_deceleration * delta)
	parent.velocity.y += parent.gravity * delta
	parent.move_and_slide()
	
	if not parent.is_on_floor():
		return fall_state
	else:
		if get_jump():
			return jump_state
		if parent.velocity.x < 1.0:
			parent.enable_detector()
	
	return null
