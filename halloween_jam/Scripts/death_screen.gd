extends Control

@onready var location = get_parent()
var ok=1

func _ready() -> void:
	Player.visible = false
	Ui.visible = false
	$Camera2D.make_current()
	Player.health = Player.maxHealth

func _process(delta: float) -> void:
	pass
		


func _on_teleport_timeout() -> void:
	Ui.ReloadHearts()
	Ui.visible = true
	Player.visible = true
	Player.died = 0
	Ui.ReloadBullets()
	Ui.ReloadHearts()
	Player.hitbox.monitorable = true
	Player.set_physics_process(true)
	for child in Player.get_children():
		if child.name == "Camera2D":
			child.make_current()
			child.get_child(0).modulate.a = 0
		
	get_tree().change_scene_to_file(Global.levels[Global.currentLevel])
