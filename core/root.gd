extends Node

@export var starting_scene: PackedScene
@export var debug_mode: bool = true

@onready var game_layer: GameLayer = %GameLayer

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel") && debug_mode:
		get_tree().quit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_layer.starting_scene = starting_scene
