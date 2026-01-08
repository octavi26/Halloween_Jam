extends Node

@onready var enemy1 = preload("res://Scenes/Enemy.tscn")
@onready var enemy2 = preload("res://Scenes/Enemy1.tscn")
@onready var enemy3 = preload("res://Scenes/Enemy2.tscn")

#speed, health, damage, attackRange, attackDelay
var enemiesTypes = {"type1" : [70, 10, 10, 200, 1],
				"type2" : [50, 20, 10, 100, 1.5],
				"type3" : [70, 15, 10, 200, 1]
				}
var levels = [
	"res://LevelScenes/Level0.tscn",
	"res://LevelScenes/Level1.tscn",
	"res://LevelScenes/Level2.tscn",
	"res://LevelScenes/Level3.tscn"
]

var currentLevel = 0
var TestAreaFinished = false

var Level0Finished = false
var Level1Finished = false
var Level2Finished = false
var Level3Finished = false

func SpawnEnemies(wave, level):
	var current_scene = get_tree().current_scene
	var spawn_points = get_tree().get_nodes_in_group("SpawnPoints")
	for enemy in wave:
		var amount = wave[enemy]
		for i in amount:
			var enemy_instance : CharacterBody2D = null
			
			if enemy == "type1":
				enemy_instance = enemy1.instantiate()
			elif enemy == "type3":
				enemy_instance = enemy3.instantiate()
			else:
				#alte tipuri
				pass
				
			enemy_instance.Initialize(enemiesTypes[enemy])
			var random_spawn : Marker2D = spawn_points.pick_random()
			spawn_points.erase(random_spawn)
			
			enemy_instance.global_position = random_spawn.global_position
			enemy_instance.tree_exiting.connect(level._on_enemy_died)
			
			current_scene.add_child(enemy_instance)
			#animatie
