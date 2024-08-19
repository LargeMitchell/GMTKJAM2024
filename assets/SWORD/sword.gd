extends Node3D


var Damage: int = 10
var TempVec: Vector3 = Vector3(2.0,2.0,2.0)
var LeveledRotation = Vector3(-44.8,9.3,132.6)
@export var exp_component: Node

func _ready() -> void:
	pass

func _on_exp_component_level_up_signal() -> void:
	print("Sword Grows")
	var current_scale: Vector3
	current_scale = self.scale
	var new_scale: Vector3
	new_scale = scale * TempVec
	
	var tween: Tween = create_tween()
	tween.tween_property(self, "scale", new_scale, 0.5)
	#self.scale_object_local(TempVec)
	#self.rotate_object_local(LeveledRotation, 0.0)
	
	pass # Replace with function body.
