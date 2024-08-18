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
@export var PlayerGroup: String #Group in which the player character is
@export var AttackGroup: String #Group in which the player's sword will be

@export_category("Node References")
@export var CollisionShape: CollisionShape3D
@export var MeshInstance: MeshInstance3D 
@export var Navigation: NavigationAgent3D 
@export var Animations: AnimationPlayer
@export var HurtBox: Area3D 
@export var AnimatedSprite: AnimatedSprite3D

@export_category("Appearance")
@export var DebugColor: Color
@export var Scale: Vector3

@onready var TargetToChase = Global.player
@onready var MeshMaterial: StandardMaterial3D = MeshInstance.get_active_material(0)
@onready var exp: PackedScene = preload("res://exp/experience.tscn")

func _ready() -> void:
	var material_override = StandardMaterial3D.new()
	material_override.albedo_color = DebugColor
	MeshInstance.set_surface_override_material(0, material_override)
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
	print("Hit - Enemy")
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
	var exp_inst: MeshInstance3D = exp.instantiate()
	get_parent().add_child(exp_inst)
	exp_inst.global_position = global_position
	queue_free()
