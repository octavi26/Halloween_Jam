extends Node2D

@onready var door = $Door

var waves = [
	{
		"type1" : 3,
		"type2" : 0
	},
	{
		"type1" : 2,
		"type2" : 0
	}
]
var currentWave = 0
var enemiesAlive = 0

func _ready() -> void:
	Player.global_position = door.global_position
	for child in Player.get_children():
			if child.name == "Camera2D":
				child.make_current()
				child.get_child(0).modulate.a = 0
	if !Global.Level1Finished:
		StartWave(currentWave)

func StartWave(wave):
	Global.SpawnEnemies(waves[wave], self)
	for cnt in waves[wave].values():
		enemiesAlive += cnt

func _on_enemy_died():
	enemiesAlive -= 1
	if enemiesAlive == 0:
		await get_tree().process_frame
		if currentWave == waves.size() - 1:
			Global.Level1Finished = true
			door.monitoring = true
			Global.currentLevel += 1
		else:
			currentWave += 1
			await get_tree().create_timer(2.0).timeout
			StartWave(currentWave)
