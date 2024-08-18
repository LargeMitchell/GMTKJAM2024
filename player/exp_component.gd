extends Node

var current_exp: int = 0
var current_level: int = 1

signal level_up_signal

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

func got_exp(amount: int) -> void:
	current_exp += amount
	if current_exp >= level_exp_dictionary[current_level]:
		level_up()

func level_up() -> void:
	current_level += 1
	Global.leveled_up.emit(current_level)
	emit_signal("level_up_signal")
