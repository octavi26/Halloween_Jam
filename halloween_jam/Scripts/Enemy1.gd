extends CharacterBody2D


@export var speed = 100
@export var health = 100
@export var damage = 10
@export var attackRange = 200
@export var attackDelay = 1
@onready var nav_agent = $NavigationAgent2D
@onready var line_of_sight = $RayCast2D
@onready var sprite = $Sprite2D
@onready var timerAttack = $Timer2

func Initialize(stats):
	speed = stats[0]
	health = stats[1]
	damage = stats[2]
	attackRange = stats[3]
	attackDelay = stats[4]

func _ready() -> void:
	$Death.play()
	timerAttack.wait_time = attackDelay

func Hit(damage):
	health -= damage
	sprite.modulate = Color(1, 0, 0)
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", Color(1, 1, 1), 0.2)
	if health <= 0:
		$Death.play(0.6)
		$Sprite2D.play("death")
		for child in get_children():
			if child.name.begins_with("hand"):
				child.queue_free()
		#queue_free()

func _physics_process(delta: float) -> void:
	if !$Spawn.is_stopped():
		return
	else:
		for child in get_children():
			if child.name.begins_with("hand"):
				child.visible = true
				
	if $Sprite2D.animation == "death" and $Sprite2D.frame == 5:
		queue_free()
		
	var path_distance = nav_agent.distance_to_target()
	line_of_sight.target_position = to_local(Player.global_position)
	line_of_sight.force_raycast_update()
	if path_distance > attackRange or line_of_sight.is_colliding():
		if !timerAttack.is_stopped():
			timerAttack.stop()
		var next_point = nav_agent.get_next_path_position()
		var dir = global_position.direction_to(next_point)
		var desired_velocity = dir * speed
		velocity = velocity.lerp(desired_velocity, delta * 10)
	else:
		velocity = velocity.lerp(Vector2.ZERO, delta * 10)
		if timerAttack.is_stopped():
			Attack()
	move_and_slide()
	if velocity.length() > 0.1:
		var dir = velocity.normalized()
		if abs(dir.x) > abs(dir.y):
			if dir.x > 0:
				#animatie merge dreapta
				sprite.flip_h = false
			else:
				#animatie stanga
				sprite.flip_h = true
		else:
			if dir.y > 0:
				#animatie jos
				pass
			else:
				#animatie sus
				pass

func _on_timer_timeout() -> void:
	nav_agent.target_position = Player.global_position
	
func Attack():
	timerAttack.start()

func _on_timer_2_timeout() -> void:
	var path_distance = nav_agent.distance_to_target()
	line_of_sight.force_raycast_update()
	if path_distance <= attackRange and !line_of_sight.is_colliding():
		#Player.Hit(damage)
		for child in get_children():
			if child.name.begins_with("hand"):
				child.shoot()
