class_name PlayerStats extends Resource

@export var current_health: int:
	set(value):
		if current_health + value > max_health:
			current_health = max_health
		Global.health_changed.emit(current_health)
@export var max_health: int
var current_exp: int
var exp_to_next_level: int
