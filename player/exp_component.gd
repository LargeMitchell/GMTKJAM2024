extends Node

var current_exp: int = 0

func _ready() -> void:
	Global.got_exp.connect(got_exp)
	print(current_exp)

func got_exp(amount: int) -> void:
	current_exp += amount
	print(current_exp)
