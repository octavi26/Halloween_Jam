extends Node2D

@export var bullet =  load("res://Scenes/ghost_bullet.tscn")
@export var nrBullets = 1
@export var spread: float = 1
@onready var root = get_node("/root")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func shoot():
	$Sound.play(0.45)
	$Timer.wait_time = 1.27 - 0.45
	var muzzlePosition = $Muzzle.global_position
	var direction = (Player.global_position - global_position).normalized()
	$Muzzle/Flash.play()
	
	#shooting_sound.pitch_scale= randf_range(0.5, 0.7)
	#shooting_sound.play()
	for i in range(nrBullets):
		var b = bullet.instantiate()
		b.direction = direction + Vector2(spread * (randf()-0.5), spread * (randf()-0.5))
		root.get_child(0).add_child(b)
		b.global_position = muzzlePosition + Vector2(100 * spread * (randf()-0.5), 100 * spread * (randf()-0.5))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var angle = (Player.global_position - global_position).angle()
	if angle < 0:
		angle += 2 * PI
	rotation = angle - PI / 2


func _on_timer_timeout() -> void:
	$Sound.stop()
