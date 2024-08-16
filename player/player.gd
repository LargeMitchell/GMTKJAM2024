extends CharacterBody3D

const SPEED = 5.0

func _physics_process(delta: float) -> void:
	var input_dir: Vector2 = Input.get_vector("left", "right", "up", "down")
	var direction: Vector3 = Vector3(input_dir.x, 0, input_dir.y).rotated(Vector3.UP, PI/4).normalized()
	velocity = direction * SPEED
	move_and_slide()
