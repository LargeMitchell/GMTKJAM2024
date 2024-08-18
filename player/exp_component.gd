extends Node

@export var player_stats: PlayerStats

var current_exp: int = 0
var current_level: int = 1

signal level_up_signal
@onready var camera: Camera3D = $"../Camera"

var level_exp_dictionary: Dictionary = {
	1: 10,
	2: 80,
	3: 200,
	4: 300,
	5: 500,
	6: 700,
	7: 1000
}

func _ready() -> void:
	Global.got_exp.connect(got_exp)
	player_stats.current_exp = current_exp
	player_stats.exp_to_next_level = level_exp_dictionary[current_level]

func got_exp(amount: int) -> void:
	current_exp += amount
	player_stats.current_exp = current_exp
	if current_exp >= level_exp_dictionary[current_level]:
		level_up()

func level_up() -> void:
	current_level += 1
	player_stats.exp_to_next_level = level_exp_dictionary[current_level]
	Global.leveled_up.emit(current_level)
	emit_signal("level_up_signal")

#Camera sizing code
	if current_level == 4:
		camera.size *= 2
	
	if current_level == 6:
		camera.size *= 2
		
	if current_level == 7:
		camera.size *= 2
