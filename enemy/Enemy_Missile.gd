extends Area3D

var Speed = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += Vector3.FORWARD * Speed * delta
