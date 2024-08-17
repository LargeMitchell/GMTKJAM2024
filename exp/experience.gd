extends MeshInstance3D

@export var move_speed: float = 2.0
@export var max_speed: float = 10.0
@export var exp_amount: int = 10

var timer: float = 0.0

func _physics_process(delta: float) -> void:
	if timer < 1.0: timer += delta
	
	
	var speed: float = lerpf(move_speed, max_speed, timer)
	var pos: Vector3 = Vector3(Global.player.global_position.x, 1.0, Global.player.global_position.z)
	var dir: Vector3 = (pos - global_position)
	global_position += dir.normalized() * speed * delta
	if dir.length_squared() < pow(0.2, 2):
		Global.got_exp.emit(exp_amount)
		queue_free()
	
