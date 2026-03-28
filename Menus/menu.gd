extends Control
@onready var button: AudioStreamPlayer2D = $Button

func _ready() -> void:
	GameManager.ButtonPress.connect(button_pressed)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	button.play()
