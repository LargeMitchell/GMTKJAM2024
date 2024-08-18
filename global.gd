extends Node

signal got_exp(amount: int)
signal leveled_up(new_level: int)
signal health_changed(new_value: int)

var player: CharacterBody3D
