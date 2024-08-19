extends Node

@export var Player_Stats : PlayerStats
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pass # Replace with function body.
	Player_Stats.current_health = 5

func reduce_health() -> void:
	Player_Stats.current_health -=1
	
func refill_health() -> void:
	Player_Stats.current_health = 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Player gets damaged here
func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("Enemy"):
		reduce_health()
	#Check player death if 0 or below load death screen	
	if Player_Stats.current_health <= 0:
		print("death of player")
		get_tree().change_scene_to_file("res://assets/Menu/DeathScreen.tscn")
