extends State

@export var fall_state: State
@export var jump_state: State
@export var move_state: State

func process_input(_event: InputEvent) -> State:
	if get_movement_inputx() != 0.0 or get_movement_inputy()!= 0.0:
		return move_state
	return null

func process_physics(delta: float) -> State:
	parent.velocity.x = move_toward(parent.velocity.x, 0.0, parent.move_deceleration * delta)
	parent.velocity.y = move_toward(parent.velocity.y, 0.0, parent.move_deceleration * delta)
	parent.move_and_slide()
	return null
