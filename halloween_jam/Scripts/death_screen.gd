extends Control

@onready var location = get_parent()
var ok=1

func _ready() -> void:
	Player.visible = false
	$Camera2D.make_current()
	Player.health = Player.maxHealth
	Player.position = Vector2(0, 0)

func _process(delta: float) -> void:
	
	print($Teleport.time_left)
	if $Teleport.time_left < 0.001:
		print("succes")
		Player.visible = true
		for child in Player.get_children():
			if child.name == "Camera2D":
				child.make_current()
				child.get_child(0).modulate.a = 0
		
		get_tree().change_scene_to_file("res://Test_Things/Testing_Area/TestArea.tscn")
		
