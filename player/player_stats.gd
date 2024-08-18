class_name PlayerStats extends Resource

@export var current_health: int:
	set(value):
		if value > max_health:
			current_health = max_health
		else:
			current_health = value
		Global.health_changed.emit(current_health)
@export var max_health: int
var current_exp: int
var exp_to_next_level: int:
	set(value):
		exp_to_next_level = value
		Global.new_max_exp.emit(value)
