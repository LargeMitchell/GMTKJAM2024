extends Node

@export var player_stats: PlayerStats
@onready var camera: Camera3D = $"../Camera"

var current_exp: int = 0
var current_level: int = 1


var camera_speed: float = 2.0
var target_camera_size: float = 15.0

signal level_up_signal

var level_exp_dictionary: Dictionary = {
	1: 20,
	2: 80,
	3: 200,
	4: 300,
	5: 500,
	6: 700,
	7: 1000,
	8: 1300,
	9: 1700,
	10: 2200,
	11: 2300
}

func _ready() -> void:
	Global.got_exp.connect(got_exp)
	player_stats.current_exp = current_exp
	player_stats.exp_to_next_level = level_exp_dictionary[current_level]

# Added to smooth out camera zoom.
func _process(delta: float) -> void:
	#camera.size = lerpf(camera.size, target_camera_size, camera_speed * delta)
	var tween: Tween = create_tween()
	tween.tween_property(camera, "size", target_camera_size, 0.5)
	
func got_exp(amount: int) -> void:
	current_exp += amount
	player_stats.current_exp = current_exp
	Global.exp_applied.emit()
	if current_exp >= level_exp_dictionary[current_level]:
		level_up()

func level_up() -> void:
	current_level += 1
	if current_level == 11:
		Core.load_scene.emit(preload("res://assets/Menu/VictoryScreen.tscn"))
	player_stats.exp_to_next_level = level_exp_dictionary[current_level]
	player_stats.current_health = 5
	Global.leveled_up.emit(current_level)
	emit_signal("level_up_signal")
	print("Level: ", current_level)
	
#Camera sizing code
	if current_level == 4:
		target_camera_size = camera.size * 1.5
		camera.position *= 1.5
		
	if current_level == 5:
		target_camera_size = camera.size * 1.5
		camera.position *= 1.5
		
	if current_level == 6:
		target_camera_size = camera.size * 2
		camera.position *= 2
		
	if current_level == 7:
		target_camera_size = camera.size * 2
		camera.position *= 2
	
	if current_level == 8:
		target_camera_size = camera.size * 2
		camera.position *= 2
	
	if current_level == 9:
		target_camera_size = camera.size * 2
		camera.position *= 2


	
