extends Node2D

@onready var press_audio_stream_player: AudioStreamPlayer = $PressAudioStreamPlayer
@onready var hover_audio_stream_player: AudioStreamPlayer = $HoverAudioStreamPlayer
@onready var exit_audio_stream_player: AudioStreamPlayer = $ExitAudioStreamPlayer

func _ready() -> void:
	Global.toggle_menu.emit()
	
#Play button sound & function
func _on_play_pressed() -> void:
	press_audio_stream_player.play()
	Core.load_scene.emit(preload("res://level/game.tscn"))

func _on_play_mouse_entered() -> void:
	hover_audio_stream_player.play()
	
func _on_play_mouse_exited() -> void:
	exit_audio_stream_player.play()

#Quit button sound & function
func _on_quit_pressed() -> void:
	press_audio_stream_player.play()
	get_tree().quit()

func _on_quit_mouse_entered() -> void:
	hover_audio_stream_player.play()

func _on_quit_mouse_exited() -> void:
	exit_audio_stream_player.play()
