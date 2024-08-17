extends Node

var current_exp: int = 0
var current_level: int = 1

var level_exp_dictionary: Dictionary = {
	1: 30,
	2: 80,
	3: 200,
}

func _ready() -> void:
	Global.got_exp.connect(got_exp)

func got_exp(amount: int) -> void:
	current_exp += amount
	if current_exp >= level_exp_dictionary[current_level]:
		level_up()

func level_up() -> void:
	current_level += 1
	print("level up", str(current_level))
