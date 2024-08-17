extends Node3D

var Damage: int = 10
var TempVec: Vector3 = Vector3(2.0,2.0,2.0)

@export var exp_component: Node

func _ready() -> void:
	pass

func _on_exp_component_level_up_signal() -> void:
	print("Sword Grows")
	self.scale_object_local(TempVec)
	pass # Replace with function body.
