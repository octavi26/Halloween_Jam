extends Node2D

func _ready() -> void:
	Player.visible = false
	Player.set_physics_process(false)
	$Camera2D.make_current()
	Player.health = Player.maxHealth
	Player.global_position = Vector2(-5, -11)
	Ui.visible = false
	
	var win_text = """
[center][font_size=36][color=yellow][b]Total Deaths:[/b][/color] [color=red]%s[/color][/font_size][/center]

[font_size=25]
The game was created in only 2 days by only 2 people, so please excuse the eventual bugs.
You WON!

[font_size=25]
[b]Developers:[/b]
Danciu Cosmin - Programming & Level Design & Sound
Radu Octavian - Programming & Art

Press [color=orange]SPACE[/color] to continue
[/font_size]
"""

	$Label.text = win_text % Player.cntDeaths




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		Global.Level0Finished = false
		Global.Level1Finished = false
		Global.Level2Finished = false
		Global.Level3Finished = false
		Global.currentLevel = 0
		Player.visible = true
		Ui.visible = true
		for child in Player.get_children():
			if child.name == "Camera2D":
				child.make_current()
				child.get_child(0).modulate.a = 0
		
		get_tree().change_scene_to_file("res://Scenes/Credits2.tscn")
