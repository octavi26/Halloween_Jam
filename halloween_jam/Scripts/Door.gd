extends Area2D

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if Global.currentLevel < Global.levels.size():
		Player.changeScene(Global.levels[Global.currentLevel])
	else:
		Player.changeScene("res://Scenes/Credits.tscn")
