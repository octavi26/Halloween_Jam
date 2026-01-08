class_name player extends CharacterBody2D

var step_sounds = [
	preload("res://Assets/Sounds/step1.ogg"),
	preload("res://Assets/Sounds/step2.ogg"),
	preload("res://Assets/Sounds/step3.ogg"),
	preload("res://Assets/Sounds/step4.ogg")
]

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
@onready var hitbox = $HitBox

var cntDeaths = 0
var died = 0
var nextScene = 0

func Hit(damage):
	if health > 0:
		health -= damage
		$AnimatedSprite2D.modulate = Color(1, 0, 0)
		var tween = create_tween()
		tween.tween_property($AnimatedSprite2D, "modulate", Color(1, 1, 1), 0.2)
		Ui.EliminateHeart()
	if health <= 0 and !died:
		cntDeaths += 1
		hitbox.monitorable = false
		Player.visible = false
		died = 1
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
		Ui.visible = true
		#Player.set_physics_process(true)
	
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
		
	if velocity and is_physics_processing():
		PlayStep()
		action = "walk"
	else:
		action = "idle"
		
	$AnimatedSprite2D.play(action + "_" + direction)
	#rotation = angle

func PlayStep():
	if $Steps.playing:
		return
	var random_step = step_sounds[randi() % step_sounds.size()]
	$Steps.stream = random_step
	if $Timer.time_left <= 0:
		$Steps.pitch_scale = randf_range(0.8, 1.2)
		$Steps.play()
		$Timer.start(0.4)

func die() -> void:
	set_physics_process(false)
	get_tree().call_group("ghost-bullets", "queue_free")
	changeScene("res://Scenes/Death_Screen.tscn")

func changeScene(scene):
	var tween = create_tween()
	tween.tween_property($Camera2D/ColorRect, "modulate:a", 1, 1)
	nextScene = scene
	Ui.visible = false
	#Player.set_physics_process(false)
	$SceneChange.start()
