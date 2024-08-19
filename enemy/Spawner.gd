extends Node3D

@export_category("Spawner Variables")
@export var SpawnRange: float #Range around player for spawning
@export var Enabled: bool

@export_category("Node References")
@export var SpawnTimer: Timer

@export_category("Enemy Waves") #Wave will be transitioned to at certain levels
@export var Wave1: Array[PackedScene] 
@export var Wave2: Array[PackedScene]
@export var Wave3: Array[PackedScene]
@export var Wave4: Array[PackedScene]
@export var Wave5: Array[PackedScene]
@export var Wave6: Array[PackedScene]
@export var Wave7: Array[PackedScene]
@export var Wave8: Array[PackedScene]
@export var Wave9: Array[PackedScene]
@export var Wave10: Array[PackedScene]

@export var SpawnInterval: int
@export var SpawnInterval2: int
@export var SpawnInterval3: int
@export var SpawnInterval4: int
@export var SpawnInterval5: int
@export var SpawnInterval6: int
@export var SpawnInterval7: int
@export var SpawnInterval8: int
@export var SpawnInterval9: int
@export var SpawnInterval10: int

var CurrentInterval: int


@onready var NodeOwner = owner #Should be the level's root node
@onready var Player = get_tree().get_first_node_in_group("Player")

var CurrentWave: Array[PackedScene]

func _ready() -> void:
	CurrentInterval = SpawnInterval
	SpawnTimer.wait_time = CurrentInterval
	CurrentWave = Wave1
	Global.leveled_up.connect(set_wave)
	if Enabled: 
		SpawnTimer.paused = false
	if not Enabled:
		SpawnTimer.paused = true

func set_wave(current_level): #On Level Up, set wave based on new player level
	match current_level:
		1:
			CurrentWave = Wave1
			CurrentInterval = SpawnInterval
		2:
			CurrentWave = Wave2
			CurrentInterval = SpawnInterval2
		3:
			CurrentWave = Wave3
			CurrentInterval = SpawnInterval3
		4:
			CurrentWave = Wave4
			CurrentInterval = SpawnInterval4
		5:
			CurrentWave = Wave5
			CurrentInterval = SpawnInterval5
		6:
			CurrentWave = Wave6
			CurrentInterval = SpawnInterval6
		7:
			CurrentWave = Wave7
			CurrentInterval = SpawnInterval7
		8:
			CurrentWave = Wave8
			CurrentInterval = SpawnInterval8
		9:
			CurrentWave = Wave9
			CurrentInterval = SpawnInterval9
		10:
			CurrentWave = Wave10
			CurrentInterval = SpawnInterval10
	print(CurrentWave)
	
func _on_spawn_timer_timeout() -> void:
	var picked_enemy = CurrentWave.pick_random()
	var instance = picked_enemy.instantiate()
	var x_pos = randf_range(Player.global_position.x - SpawnRange, Player.global_position.x + SpawnRange)
	var y_pos = randf_range(Player.global_position.z - SpawnRange, Player.global_position.z + SpawnRange)
	owner.add_child(instance)
	instance.global_position = Vector3(x_pos, 1, y_pos)
	
