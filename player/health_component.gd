extends Node

@export var Player_Stats : PlayerStats
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	Player_Stats.current_health = 5

func reduce_health() -> void:
	Player_Stats.current_health -=1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("Enemy"):
		reduce_health()
