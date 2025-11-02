extends Node2D

func _ready() -> void:
	Player.visible = false
	$Camera2D.make_current()
	Player.health = Player.maxHealth
	Player.position = Vector2(0, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		print("succes")
		Player.visible = true
		for child in Player.get_children():
			if child.name == "Camera2D":
				child.make_current()
				child.get_child(0).modulate.a = 0
		
		get_tree().change_scene_to_file("res://Test_Things/Testing_Area/TestArea.tscn")
