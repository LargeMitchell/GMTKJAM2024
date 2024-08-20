extends Node2D

@onready var press_audio_stream_player: AudioStreamPlayer = $PressAudioStreamPlayer
@onready var hover_audio_stream_player: AudioStreamPlayer = $HoverAudioStreamPlayer
@onready var exit_audio_stream_player: AudioStreamPlayer = $ExitAudioStreamPlayer


#Restart button sounds & functionality
func _on_restart_pressed() -> void:
	press_audio_stream_player.play()
	get_tree().change_scene_to_file("res://core/root.tscn")
	
func _on_restart_mouse_entered() -> void:
	hover_audio_stream_player.play()

func _on_restart_mouse_exited() -> void:
	exit_audio_stream_player.play()

#Quit button sounds & functionality
func _on_quit_pressed() -> void:
	press_audio_stream_player.play()
	get_tree().quit()

func _on_quit_mouse_entered() -> void:
	hover_audio_stream_player.play()


func _on_quit_mouse_exited() -> void:
	exit_audio_stream_player.play()
