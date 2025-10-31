extends State

@export var fall_state: State
@export var idle_state: State
@export var move_state: State

func enter() -> void:
	var move_direction := signf(get_movement_input())
	parent.velocity.x += move_direction * parent.jump_horizontal_speed
	parent.velocity.y = parent.jump_vertical_speed

func process_physics(delta: float) -> State:
	var move_direction := signf(get_movement_input())
	parent.velocity.x = move_toward(parent.velocity.x, 
		move_direction * parent.jump_horizontal_speed, parent.air_acceleration * delta)
	sprite.flip_h = move_direction < 0.0
	
	parent.velocity.y += parent.up_gravity * delta
	parent.velocity.y = minf(parent.velocity.y, parent.max_fall_speed)
	parent.move_and_slide()
	
	if parent.velocity.y > 0:
		return fall_state

	if parent.is_on_floor():
		if move_direction != 0.0:
			return move_state
		return idle_state
	
	return null
