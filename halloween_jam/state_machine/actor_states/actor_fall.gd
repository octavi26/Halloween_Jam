extends State

@export var idle_state: State
@export var move_state: State
@export var jump_state: State

var jump_buffer_timer := 0.0

func enter() -> void:
	jump_buffer_timer = 0.0
	
func exit() -> void:
	parent.coyote_timer = 0.0

func process_input(_event: InputEvent) -> State:
	if get_jump():
		jump_buffer_timer = parent.jump_buffer_time
	return null
	
func process_physics(delta: float) -> State:
	var move_direction := signf(get_movement_input())
	parent.velocity.x = move_toward(parent.velocity.x, 
		move_direction * parent.jump_horizontal_speed, parent.air_acceleration * delta)
	sprite.flip_h = move_direction < 0.0
	
	parent.velocity.y += parent.fall_gravity * delta
	parent.velocity.y = minf(parent.velocity.y, parent.max_fall_speed)
	parent.move_and_slide()
	
	if parent.coyote_timer > 0.0 and jump_buffer_timer > 0.0:
		return jump_state
		
	if parent.is_on_floor():
		if jump_buffer_timer > 0.0:
			return jump_state
		if move_direction != 0.0:
			return move_state
		return idle_state
	
	parent.coyote_timer -= delta
	jump_buffer_timer -= delta

	return null
