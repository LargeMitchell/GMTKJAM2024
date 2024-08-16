class_name GameLayer extends CanvasLayer

@onready var game_view: SubViewport = %GameSubViewport

var starting_scene: PackedScene

func _ready() -> void:
	Core.load_scene.connect(load_scene)
	
	await get_parent().ready
	assert(starting_scene, "No Starting Scene given to Root!")
	load_scene(starting_scene)

func load_scene(desired_scene: PackedScene) -> void:
	if game_view.get_child_count() > 0:
		game_view.get_child(0).free()
	
	deferred_load.call_deferred(desired_scene)

func deferred_load(s: PackedScene) -> void:
	var scene: Node = s.instantiate()
	game_view.add_child(scene)
	Core.scene_changed.emit(s)
