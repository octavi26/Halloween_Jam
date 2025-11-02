extends Node

@onready var enemy1 = preload("res://Test_Things/Testing_Area/Enemy.tscn")
@onready var enemy2 = preload("res://Test_Things/Testing_Area/Enemy2.tscn")

#speed, health, damage, attackRange, attackDelay
var enemiesTypes = {"type1" : [70, 10, 10, 200, 1],
				"type2" : [150, 150, 5, 300, 1]
				}

var TestAreaFinished = false
var TestAreaDoors = false

func SpawnEnemies(wave, level):
	var current_scene = get_tree().current_scene
	var spawn_points = get_tree().get_nodes_in_group("SpawnPoints")
	for enemy in wave:
		var amount = wave[enemy]
		for i in amount:
			var enemy_instance : CharacterBody2D = null
			
			if enemy == "type1":
				enemy_instance = enemy1.instantiate()
			elif enemy == "type2":
				enemy_instance = enemy2.instantiate()
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
