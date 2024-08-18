extends Control

@export var player_stats: PlayerStats

@onready var heart_panel: PackedScene = preload("res://player/ui/heart_panel.tscn")
@onready var exp_bar: ProgressBar = $EXPBar/ProgressBar

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		health_changed(3)

func _ready() -> void:
	set_max_health(player_stats.max_health)
	
	Global.health_changed.connect(health_changed)
	Global.new_max_exp.connect(new_level)

func set_max_health(max: int) -> void:
	for i in range(max):
		var heart = heart_panel.instantiate()
		$HeartContainer.add_child(heart)

func health_changed(new_value: int) -> void:
	var hearts: Array[Node] = $HeartContainer.get_children()
	for heart in hearts:
		if heart.get_index() < new_value:
			heart.get_child(0).frame = 0
		else:
			heart.get_child(0).frame = 1

func new_level(new_value: int) -> void:
	exp_bar.max_value = new_value
	exp_bar.min_value = player_stats.current_exp
