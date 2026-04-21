extends Node2D

@onready var rotation_offset: Area2D = $RotationOffset
@onready var sprite_2d: Sprite2D = $RotationOffset/Sprite2D

@export var speedRotation: float = 4.5

var rotation_value := 0.0

var radius: float = 188
var start_angle: float = -deg_to_rad(30)
var end_angle: float = deg_to_rad(30)
var point_count: int = 30
var width: float = 36


func _draw() -> void:
	draw_arc(Vector2.ZERO, radius, start_angle, end_angle, point_count, Color.GREEN, width)

func _ready() -> void:
	GameManager.ArduinoRead.connect(_on_arduino_read)
	print($RotationOffset.area_entered.get_connections())
	rotation = deg_to_rad(0)

func _physics_process(_delta: float) -> void:
	var _key_pressed := false
		# Rotation Input Through Keyboard 
	if Input.is_action_pressed("Up") and Input.is_action_pressed("Right"):
		rotation = deg_to_rad(315)
		_key_pressed = true
	elif Input.is_action_pressed("Up") and Input.is_action_pressed("Left"):
		rotation = deg_to_rad(225)
		_key_pressed = true
	elif Input.is_action_pressed("Down") and Input.is_action_pressed("Right"):
		rotation = deg_to_rad(45)
		_key_pressed = true
	elif Input.is_action_pressed("Down") and Input.is_action_pressed("Left"):
		rotation = deg_to_rad(135)
		_key_pressed = true
	elif Input.is_action_pressed("Up"):
		rotation = deg_to_rad(270)
		_key_pressed = true
	elif Input.is_action_pressed("Left"):
		rotation = deg_to_rad(180)
		_key_pressed = true
	elif Input.is_action_pressed("Right"):
		rotation = deg_to_rad(0)
		_key_pressed = true
	elif Input.is_action_pressed("Down"):
		rotation = deg_to_rad(90)
		_key_pressed = true
	
	#Rotation Input Through Mouse (only when no key is pressed)
	#if not _key_pressed:
		#rotation_offset.rotation = lerp_angle(rotation_offset.rotation, (get_global_mouse_position() - global_position).angle(), 10*delta)
	#look_at(get_global_mouse_position())
	


func _on_rotation_offset_area_entered(_area: Area2D) -> void:
	if  _area and _area.is_in_group("bullets"):
		Global.score += 1
		$HitSound.play()
	elif _area and _area.is_in_group("health"):
		Global.score -= 1
		$HealFail.play()

func _on_arduino_read(response: Variant) -> void:
	#rotation = deg_to_rad(response * speedRotation)
	rotation = lerp_angle(rotation, deg_to_rad(response * speedRotation), 0.15)
	#print(rotation_offset.rotation_degrees)

#func _on_game_manager_arduino_read(response: Variant) -> void:
	#rotation_offset.rotation = deg_to_rad(response * speedRotation)
	#print(rotation_offset.rotation_degrees)
