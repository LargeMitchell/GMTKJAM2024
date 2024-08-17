extends Node3D
var Damage: int = 10
@export var exp_component: Node



func _on_exp_component_level_up_signal() -> void:
	print("Sword Grows")
	pass # Replace with function body.
