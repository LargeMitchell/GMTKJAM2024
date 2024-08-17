extends Node3D

var SwordDamage:int = 10
@onready var Swordarea_3d: Area3D = $Area3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_3d_area_entered(area: Area3D) -> void:
	pass


func _on_area_3d_body_entered(EnemyBody: Node3D) -> void:
	print("Im hitting I swear")
	if EnemyBody.is_in_group("Enemy"):
		EnemyBody.hit(SwordDamage)
