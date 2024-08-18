extends Node

signal got_exp(amount: int)
signal exp_applied
signal leveled_up(new_level: int)
signal health_changed(new_value: int)
signal new_max_exp(value: int)

var player: CharacterBody3D
