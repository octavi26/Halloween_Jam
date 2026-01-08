extends Node2D

var waves = [
	{
		"type1" : 0,
		"type3" : 1
	},
	{
		"type1" : 2,
		"type2" : 0
	}
]
var currentWave = 0
var enemiesAlive = 0

func _ready() -> void:
	if !Global.TestAreaFinished:
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
			Global.TestAreaFinished = true
			Global.TestAreaDoors = true
		else:
			currentWave += 1
			await get_tree().create_timer(2.0).timeout
			StartWave(currentWave)
