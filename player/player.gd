extends CharacterBody3D

const SPEED = 5.0

@onready var mesh_root: Node3D = $Guy
@onready var animation_player: AnimationPlayer = $Guy/AnimationPlayer

func _ready() -> void:
	Global.player = self
	
	animation_player.play("Idle")

func _physics_process(delta: float) -> void:
	var input_dir: Vector2 = Input.get_vector("left", "right", "up", "down")
	var direction: Vector3 = Vector3(input_dir.x, 0, input_dir.y).rotated(Vector3.UP, PI/4).normalized()
	velocity = direction * SPEED
	if direction:
		mesh_root.global_rotation.y = atan2(velocity.x,velocity.z)
		animation_player.play("Walk")
	move_and_slide()
