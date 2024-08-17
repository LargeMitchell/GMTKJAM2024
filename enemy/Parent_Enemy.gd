extends CharacterBody3D

class_name Enemy

#State setup
enum {SPAWNING, ACTIVE, DYING}
var State: int = 1
var StateName: String = ""

var MapQuery: bool = false

var CurrentHealth: int

@export_category("Enemy Variables")
@export var Speed: float
@export var XP: int
@export var MaxHealth: int
@export var CanMove: bool
@export var Damage: int
@export var PlayerGroup: String #Group in which the player character is
@export var AttackGroup: String #Group in which the player's sword will be

@export_category("Node References")
@export var CollisionShape: CollisionShape3D
@export var MeshInstance: MeshInstance3D 
@export var Navigation: NavigationAgent3D 
@export var Animations: AnimationPlayer
@export var HurtBox: Area3D 

@export_category("Appearance")
@export var DebugColor: Color
@export var Scale: Vector3

@onready var TargetToChase = get_tree().get_first_node_in_group("Player")
@onready var MeshMaterial: StandardMaterial3D = MeshInstance.get_active_material(0)

func _ready() -> void:
	scale = Scale
	State = ACTIVE
	MeshMaterial.albedo_color = DebugColor
	CurrentHealth = MaxHealth
	
	
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
	
	move_and_slide()

func spawning_state() -> void:
	pass
	
func active_state() -> void:
	StateName = "Active"
	if CanMove == true and MapQuery == true:
		Navigation.target_position = TargetToChase.global_position
		velocity = global_position.direction_to(Navigation.get_next_path_position()) * Speed
	
func dying_state() -> void:
	pass

func hit(DamageReceived: int, body: Node3D):
	if body.is_in_group(AttackGroup):
		if CurrentHealth > 0:
			CurrentHealth = CurrentHealth - DamageReceived
			Animations.play("Hit")
		elif CurrentHealth < 1: 
			queue_free()
	
func _on_timer_timeout() -> void:
	MapQuery = true
