extends Node2D

func _ready() -> void:
	Player.visible = false
	Player.set_physics_process(false)
	$Camera2D.make_current()
	Player.health = Player.maxHealth
	#Player.global_position = Vector2(-5, -11)
	Ui.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		Player.visible = true
		Ui.visible = true
		Player.set_physics_process(true)
		for child in Player.get_children():
			if child.name == "Camera2D":
				child.make_current()
				child.get_child(0).modulate.a = 0
		
		get_tree().change_scene_to_file("res://LevelScenes/Level0.tscn")
