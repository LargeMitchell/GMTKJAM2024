extends CharacterBody3D

class_name Enemy

#State setup
enum {SPAWNING, ACTIVE, DYING, SHOOTING}
var State: int = 1
var StateName: String = ""

var MapQuery: bool = false

var CurrentHealth: int

@export_category("Enemy Variables")
@export var Speed: float
@export var XP: int
@export var MaxHealth: int
@export var CanMove: bool
@export var CanShoot: bool
@export var Damage: int
@export var ExplosionColor: Color = Color8(156, 1, 0)
@export var PlayerGroup: String #Group in which the player character is
@export var AttackGroup: String #Group in which the player's sword will be

@export_category("Node References")
@export var CollisionShape: CollisionShape3D
@export var Navigation: NavigationAgent3D 
@export var Animations: AnimationPlayer
@export var HurtBox: Area3D 
@export var HurtBoxShape: CollisionShape3D
@export var AnimatedSprite: AnimatedSprite3D
@export var DeathExplosion: CPUParticles3D

@export_category("Appearance")
@export var Scale: Vector3

@onready var TargetToChase = Global.player
@onready var exp: PackedScene = preload("res://exp/experience.tscn")
@onready var hit_stream_player: AudioStreamPlayer = $HitStreamPlayer

var dead: bool = false

func _ready() -> void:
	var material_override = StandardMaterial3D.new()
	scale = Scale
	State = ACTIVE
	CurrentHealth = MaxHealth
	
	$AnimatedSprite3D.play("default")
	call_deferred("actor_setup")

#Await the NavigationServer before you attempt to move, otherwise big error
func actor_setup():
	await NavigationServer3D.map_changed
	MapQuery = true


func _physics_process(delta: float) -> void:
	match State:
		SPAWNING: spawning_state()
		ACTIVE: active_state()
		DYING: dying_state()
		SHOOTING: shooting_state()
		
	calculate_distance()
	if velocity.x > 1:
		AnimatedSprite.flip_h = false
	elif velocity.x < 1: 
		AnimatedSprite.flip_h = true
	
	move_and_slide()

func spawning_state() -> void:
	pass
	
func active_state() -> void:
	StateName = "Active"
	
	if CanShoot and calculate_distance() < 6:
		State = SHOOTING
	
	if CanMove == true and MapQuery == true:
		Navigation.target_position = Global.player.global_position
		velocity = global_position.direction_to(Navigation.get_next_path_position()) * Speed
	
	
	
func dying_state() -> void:
	pass

func shooting_state() -> void:
	if CanShoot and calculate_distance() > 7:
		State = ACTIVE
	

func hit(DamageReceived: int):
	Animations.play("Hit")
	play_audio(hit_stream_player)
	CurrentHealth = CurrentHealth - DamageReceived
	
	if CurrentHealth <= 1: 
		die()
		print("DEATH")

func _on_timer_timeout() -> void:
	MapQuery = true

func calculate_distance(): 
	var distance_calculated
	var distance_length
	distance_calculated = Global.player.global_position - global_position
	distance_length = distance_calculated.length()
	return distance_length


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("AttackGroup"):
		hit(area.Damage)

func die() -> void:
	if dead == false:
		var exp_inst: MeshInstance3D = exp.instantiate()
		get_parent().add_child(exp_inst)
		exp_inst.global_position = global_position
		AnimatedSprite.hide()
		Global.player.apply_shake()
		emit_death_particles()
		HurtBox.queue_free()
		
		dead = true
		await DeathExplosion.finished
		queue_free()

func play_audio(AudioPlayer: AudioStreamPlayer):
	var last_pitch = 1.0
	randomize()
	AudioPlayer.pitch_scale = randf_range(0.8, 1.3)
	
	while abs(AudioPlayer.pitch_scale - last_pitch) < .1:
		randomize()
		AudioPlayer.pitch_scale = randf_range(0.8, 1.3)
	
	last_pitch = AudioPlayer.pitch_scale
	
	AudioPlayer.play()

func emit_death_particles():
	var DeathMaterial: StandardMaterial3D = StandardMaterial3D.new()
	DeathMaterial.albedo_color = ExplosionColor
	DeathExplosion.mesh.surface_set_material(0, DeathMaterial)
	DeathExplosion.emitting = true
