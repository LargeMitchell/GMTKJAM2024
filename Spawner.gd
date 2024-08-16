extends Node3D

@export_category("Spawner Variables")
@export var SpawnInterval: int
@export var EnemiesAvailable: Array[PackedScene] 
@export var SpawnRange: float #Range around player for spawning

@export_category("Node References")
@export var SpawnTimer: Timer

@onready var NodeOwner = owner #Should be the level's root node
@onready var Player = get_tree().get_first_node_in_group("TestPlayer")

func _ready() -> void:
	SpawnTimer.wait_time = SpawnInterval

func _on_spawn_timer_timeout() -> void:
	var picked_enemy = EnemiesAvailable.pick_random()
	var instance = picked_enemy.instantiate()
	var x_pos = randf_range(Player.global_position.x - SpawnRange, Player.global_position.x + SpawnRange)
	var y_pos = randf_range(Player.global_position.z - SpawnRange, Player.global_position.z + SpawnRange)
	owner.add_child(instance)
	instance.global_position = Vector3(x_pos, 1, y_pos)
	
