extends CanvasLayer

@onready var bullets = $Bullets.get_children()
@onready var hearts = $Health.get_children()
@onready var timer = $Timer

func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	pass
	

func EliminateHeart():
	var chosenHeart = hearts[Player.health]
	chosenHeart.modulate.a = 0.2
	
func ReloadHearts():
	for heart in hearts:
		heart.modulate.a = 1.0

func EliminateBullet():
	var chosenBullet = bullets[Player.bullets]
	chosenBullet.modulate.a = 0.2
	
func ReloadBullets():
	Player.bullets = 5
	for bullet in bullets:
		bullet.modulate.a = 1.0

func _on_timer_timeout() -> void:
	ReloadBullets()
