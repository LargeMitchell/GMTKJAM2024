extends CharacterBody3D

const SPEED = 5.0

@onready var mesh_root: Node3D = $Guy
@onready var animation_player: AnimationPlayer = $Guy/AnimationPlayer
@onready var woosh_stream_player: AudioStreamPlayer = $AudioStreamPlayer

@onready var camera = $Camera
var rayOrigin = Vector3()
var rayEnd = Vector3()
var attacking: bool = false

func _ready() -> void:
	Global.player = self
	
	animation_player.play("Idle")

func _physics_process(delta: float) -> void:
	var input_dir: Vector2 = Input.get_vector("left", "right", "up", "down")
	var direction: Vector3 = Vector3(input_dir.x, 0, input_dir.y).rotated(Vector3.UP, PI/4).normalized()
	velocity = direction * SPEED
	if direction:
		mesh_root.global_rotation.y = atan2(velocity.x,velocity.z)
		if not attacking:
			animation_player.play("Walk")
	
	if Input.is_action_pressed("attack"):
		attacking = true
		if not animation_player.current_animation == "AttackSwing2":
			play_audio(woosh_stream_player)
		animation_player.play("AttackSwing2")
		
		
	var space_state = get_world_3d().direct_space_state
	var mouse_position = get_viewport().get_mouse_position()
	
	rayOrigin = camera.project_ray_origin(mouse_position)
	rayEnd = rayOrigin + camera.project_ray_normal(mouse_position) * 2000
	
	var query = PhysicsRayQueryParameters3D.create(rayOrigin,rayEnd)
	var intersection = space_state.intersect_ray(query)
	
	if not intersection.is_empty():
		var pos = -intersection.position
		$Guy.look_at(Vector3(pos.x, global_position.y, pos.z), Vector3(0,1,0))
	
	move_and_slide()
	
func _on_animation_player_animation_finished(AttackSwing1: StringName) -> void:
	attacking = false

func play_audio(AudioPlayer: AudioStreamPlayer):
	var last_pitch = 1.0
	randomize()
	AudioPlayer.pitch_scale = randf_range(0.8, 1.2)
	
	while abs(AudioPlayer.pitch_scale - last_pitch) < .1:
		randomize()
		AudioPlayer.pitch_scale = randf_range(0.8, 1.2)
	
	last_pitch = AudioPlayer.pitch_scale
	
	AudioPlayer.play()
