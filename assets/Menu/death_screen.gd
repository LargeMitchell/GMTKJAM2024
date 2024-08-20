extends Node2D

@onready var press_audio_stream_player: AudioStreamPlayer = $PressAudioStreamPlayer
@onready var hover_audio_stream_player: AudioStreamPlayer = $HoverAudioStreamPlayer
@onready var exit_audio_stream_player: AudioStreamPlayer = $ExitAudioStreamPlayer

func _ready() -> void:
	Global.toggle_menu.emit()

#Restart button sounds & functionality
func _on_restart_pressed() -> void:
	Core.load_scene.emit(preload("res://level/game.tscn"))

func _on_restart_mouse_entered() -> void:
	hover_audio_stream_player.play()

func _on_restart_mouse_exited() -> void:
	exit_audio_stream_player.play()

#Quit button sounds & functionality
func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_quit_mouse_entered() -> void:
	hover_audio_stream_player.play()

func _on_quit_mouse_exited() -> void:
	exit_audio_stream_player.play()
