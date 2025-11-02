extends Node2D

@export var bullet =  load("res://Scenes/bullet.tscn")
@export var nrBullets = 5
@export var spread: float = 1
@onready var root = get_node("/root")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func shoot(muzzlePosition: Vector2, direction: Vector2):
	$Muzzle_East/Flash.play()
	$Muzzle_South/Flash.play()
	$Muzzle_North/Flash.play()
	$Muzzle_West/Flash.play()
	
	#shooting_sound.pitch_scale= randf_range(0.5, 0.7)
	#shooting_sound.play()
	for i in range(nrBullets):
		var b = bullet.instantiate()
		b.direction = direction + Vector2(spread * (randf()-0.5), spread * (randf()-0.5))
		root.get_child(0).add_child(b)
		b.global_position = muzzlePosition + Vector2(100 * spread * (randf()-0.5), 100 * spread * (randf()-0.5))
	$Cooldown.start()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var angle = (get_global_mouse_position() - global_position).angle()
	var direction : String
	if angle < 0:
		angle += 2 * PI
	
	var muzzlePosition
	
	if angle <= PI / 4 or angle >= 7 * PI / 4:
		direction = "east"
		$AnimatedSprite2D.frame = 0
		rotation = angle
		z_index = 0
		
		muzzlePosition = $Muzzle_East.global_position
		$Muzzle_East/Flash.visible = true
		$Muzzle_South/Flash.visible = false
		$Muzzle_North/Flash.visible = false
		$Muzzle_West/Flash.visible = false
	if angle >= PI / 4 and angle <= 3 * PI / 4:
		direction = "south"
		$AnimatedSprite2D.frame = 3
		rotation = angle - PI / 2
		z_index = 0
		
		muzzlePosition = $Muzzle_South.global_position
		$Muzzle_East/Flash.visible = false
		$Muzzle_South/Flash.visible = true
		$Muzzle_North/Flash.visible = false
		$Muzzle_West/Flash.visible = false
	if angle >= 3 * PI / 4 and angle <= 5 * PI / 4:
		direction = "west"
		$AnimatedSprite2D.frame = 2
		rotation = angle - PI
		z_index = 0
		
		muzzlePosition = $Muzzle_West.global_position
		$Muzzle_East/Flash.visible = false
		$Muzzle_South/Flash.visible = false
		$Muzzle_North/Flash.visible = false
		$Muzzle_West/Flash.visible = true
	if angle >= 5 * PI / 4 and angle <= 7 * PI / 4:
		direction = "north"
		$AnimatedSprite2D.frame = 1
		rotation = angle - 3 * PI / 2
		z_index = -1
		
		muzzlePosition = $Muzzle_North.global_position
		$Muzzle_East/Flash.visible = false
		$Muzzle_South/Flash.visible = false
		$Muzzle_North/Flash.visible = true
		$Muzzle_West/Flash.visible = false
		
	if Input.is_action_just_pressed("shoot") and $Cooldown.is_stopped():
		if Player.bullets > 0:
			Player.bullets -= 1
			Ui.EliminateBullet()
			shoot(muzzlePosition, (get_global_mouse_position() - global_position).normalized())
		else:
			Ui.timer.start()
			
