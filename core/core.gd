extends Node

@warning_ignore("unused_signal")
signal load_scene(desired_scene: PackedScene)
@warning_ignore("unused_signal")
signal scene_changed(new_scene: Node)

var current_scene: PackedScene

func _ready() -> void:
	scene_changed.connect(set_current_scene)

func set_current_scene(scene: PackedScene) -> void:
	current_scene = scene
	print("new scene: " + current_scene.resource_path)
