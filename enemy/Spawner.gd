extends Node3D

@export_category("Spawner Variables")
@export var SpawnInterval: int
@export var SpawnRange: float #Range around player for spawning
@export var Enabled: bool

@export_category("Node References")
@export var SpawnTimer: Timer

@export_category("Enemy Waves") #Wave will be transitioned to at certain levels
@export var Wave1: Array[PackedScene] 
@export var Wave2: Array[PackedScene]
@export var Wave3: Array[PackedScene]

@onready var NodeOwner = owner #Should be the level's root node
@onready var Player = get_tree().get_first_node_in_group("Player")

var CurrentWave: Array[PackedScene]

func _ready() -> void:
	SpawnTimer.wait_time = SpawnInterval
	CurrentWave = Wave1
	if Enabled: 
		SpawnTimer.paused = false
	if not Enabled:
		SpawnTimer.paused = true
		
func _on_spawn_timer_timeout() -> void:
	var picked_enemy = CurrentWave.pick_random()
	var instance = picked_enemy.instantiate()
	var x_pos = randf_range(Player.global_position.x - SpawnRange, Player.global_position.x + SpawnRange)
	var y_pos = randf_range(Player.global_position.z - SpawnRange, Player.global_position.z + SpawnRange)
	owner.add_child(instance)
	instance.global_position = Vector3(x_pos, 1, y_pos)
	
