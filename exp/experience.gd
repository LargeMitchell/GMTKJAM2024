extends MeshInstance3D

@export var move_speed: float = 10.0
@export var exp_amount: int = 10

func _physics_process(delta: float) -> void:
	var pos: Vector3 = Vector3(Global.player.global_position.x, 1.0, Global.player.global_position.z)
	var dir: Vector3 = (pos - global_position)
	global_position += dir.normalized() * move_speed * delta
	if dir.length() < 0.5:
		Global.got_exp.emit(exp_amount)
		queue_free()
	
