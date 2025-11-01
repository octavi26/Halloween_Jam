extends CharacterBody2D


@export var speed = 100
@export var health = 100
@export var attackRange = 100
@export var attackDelay = 1
@onready var player = %Player
@onready var nav_agent = $NavigationAgent2D

func Hit(damage):
	health -= damage
	if health <= 0:
		queue_free()

func _physics_process(delta: float) -> void:
	if global_position.distance_to(player.global_position) <= attackRange:
		velocity = Vector2.ZERO
	else:
		nav_agent.target_position = player.global_position
		var next_point = nav_agent.get_next_path_position()
		var dir = global_position.direction_to(next_point)
		velocity = dir * speed
	move_and_slide()
