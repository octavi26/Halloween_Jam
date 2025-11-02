class_name player extends CharacterBody2D

@export var max_move_speed := 150.0 # Velocity in pixels/sec
@export var max_sprint_speed := 150.0 # Velocity in pixels/sec
@export var move_acceleration := 1500.0 # Acceleration in pixels/sec/sec
@export var move_deceleration := 2000.0 # Acceleration in pixels/sec/sec

@onready var sprite: Sprite2D = $Sprite2D
@onready var move_state_machine: Node = $MoveStateMachine
@onready var move_controller: Node = $MoveController
@onready var screen_size := get_viewport_rect().size
@onready var bullets = 5
@onready var maxHealth = 5
@onready var health = 5

var nextScene = 0

func Hit(damage):
	health -= damage
	if health <= 0:
		die()

func _ready() -> void:
	move_state_machine.init(self, sprite, move_controller)
	$Camera2D/ColorRect.modulate.a = 0

func _unhandled_input(event: InputEvent) -> void:
	move_state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	move_state_machine.process_physics(delta)

func _process(delta: float) -> void:
	if nextScene and $SceneChange.is_stopped():
		var ns = nextScene
		nextScene = 0
		get_tree().change_scene_to_file(ns)
	
	move_state_machine.process_frame(delta)
	
	var angle = (get_global_mouse_position() - global_position).angle()
	var direction : String
	var action : String = "walk"
	if angle < 0:
		angle += 2 * PI
		
	if angle <= PI / 4 or angle >= 7 * PI / 4:
		direction = "east"
	if angle >= PI / 4 and angle <= 3 * PI / 4:
		direction = "south"
	if angle >= 3 * PI / 4 and angle <= 5 * PI / 4:
		direction = "west"
	if angle >= 5 * PI / 4 and angle <= 7 * PI / 4:
		direction = "north"
		
	if velocity:
		action = "walk"
	else:
		action = "idle"
		
	$AnimatedSprite2D.play(action + "_" + direction)
	#rotation = angle

func die() -> void:
	changeScene("res://Scenes/Death_Screen.tscn")

func changeScene(scene):
	var tween = create_tween()
	tween.tween_property($Camera2D/ColorRect, "modulate:a", 1, 1)
	nextScene = scene
	$SceneChange.start()
