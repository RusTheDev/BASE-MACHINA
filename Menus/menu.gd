extends Control
@onready var button: AudioStreamPlayer2D = $Button
@onready var shader: CanvasLayer = $Shader

func _ready() -> void:
	GameManager.ButtonPress.connect(button_pressed)

func _process(_delta: float) -> void:
	if Input.is_action_pressed("Start"):
		_on_start_pressed()
	if Input.is_action_just_pressed("ShaderOff"):
		Global.shader_toggle = !Global.shader_toggle
	if Input.is_action_just_pressed("main menu"):
		_on_quit_pressed()
	if Global.shader_toggle:
		shader.hide()
	else:
		shader.show()


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
