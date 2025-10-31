class_name State extends Node

var sprite: Sprite2D
var move_controller
var parent: CharacterBody2D

func init(_parent: CharacterBody2D, _sprite: Sprite2D, _move_controller) -> void:
	self.parent = _parent
	self.sprite = _sprite
	self.move_controller = _move_controller

func enter() -> void:
	pass
	
func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

func get_movement_inputx() -> float:
	return move_controller.get_movement_directionx()
	
func get_movement_inputy() -> float:
	return move_controller.get_movement_directiony()

func get_jump() -> bool:
	return move_controller.wants_jump()

func get_sprint() -> bool:
	return move_controller.wants_sprint()
