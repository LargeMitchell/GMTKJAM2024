extends CharacterBody3D

@export_category("Player Metrics")
@export var SPEED: float = 5.0
@export var player_stats: PlayerStats

@export_category("Node References")
@export var mesh_root: Node3D 
@export var animation_player: AnimationPlayer
@export var woosh_stream_player: AudioStreamPlayer
@export var camera: Camera3D
@export var xp_particle: GPUParticles3D
@export var levelup_stream_player: AudioStreamPlayer
@export var xp_stream_player: AudioStreamPlayer

@export_category("Camera Shake")
@export var random_strength: float = 0.5
@export var shake_fade: float = 5.0

var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0

#Aiming Vars
var rayOrigin: Vector3 = Vector3()
var rayEnd: Vector3 = Vector3()
var attacking: bool = false

func _ready() -> void:
	Global.player = self
	
	Global.exp_applied.connect(on_xp_received)
	Global.leveled_up.connect(on_level_up)
	
	animation_player.play("Idle")

func _physics_process(delta: float) -> void:
	var input_dir: Vector2 = Input.get_vector("left", "right", "up", "down")
	var direction: Vector3 = Vector3(input_dir.x, 0, input_dir.y).rotated(Vector3.UP, PI/4).normalized()
	velocity = direction * SPEED
	if direction:
		#mesh_root.global_rotation.y = atan2(velocity.x,velocity.z)
		if not attacking:
			animation_player.play("Walk")
	
	if Input.is_action_pressed("attack"):
		attacking = true
		if not animation_player.current_animation == "AttackSwing2":
			play_audio(woosh_stream_player)
		animation_player.play("AttackSwing2")
	
	#if Input.is_action_pressed("spin"):
		#animation_player.play("AttackPose")
		
		
	var space_state = get_world_3d().direct_space_state
	var mouse_position = get_viewport().get_mouse_position()
	
	rayOrigin = camera.project_ray_origin(mouse_position)
	rayEnd = rayOrigin + camera.project_ray_normal(mouse_position) * 2000
	
	var query = PhysicsRayQueryParameters3D.create(rayOrigin,rayEnd)
	var intersection = space_state.intersect_ray(query)
	
	if not intersection.is_empty():
		var pos = intersection.position
		$Guy.look_at(Vector3(pos.x, global_position.y, pos.z), Vector3.UP, true)
	
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
		
		camera.set_h_offset(rng.randf_range(-shake_strength, shake_strength))
		camera.set_v_offset(rng.randf_range(-shake_strength, shake_strength))
	
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

func apply_shake():
	shake_strength = random_strength

func random_offset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))

func on_xp_received() -> void:
	print("XPGot")
	xp_particle.emitting = true
	play_audio(xp_stream_player)

func on_level_up(new_level):
	play_audio(levelup_stream_player)
