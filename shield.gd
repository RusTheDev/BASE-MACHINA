extends Node2D

@onready var rotation_offset: Area2D = $RotationOffset
@onready var sprite_2d: Sprite2D = $RotationOffset/Sprite2D

@export var speedRotation: float = 3.5

var rotation_value := 0.0

func _physics_process(_delta: float) -> void:
	var key_pressed := false
	
		# Rotation Input Through Keyboard 
	if Input.is_action_pressed("Up") and Input.is_action_pressed("Right"):
		rotation_offset.rotation = deg_to_rad(315)  # Up-Right
		key_pressed = true
	elif Input.is_action_pressed("Up") and Input.is_action_pressed("Left"):
		rotation_offset.rotation = deg_to_rad(225)  # Up-Left
		key_pressed = true
	elif Input.is_action_pressed("Down") and Input.is_action_pressed("Right"):
		rotation_offset.rotation = deg_to_rad(45)  # Down-Right
		key_pressed = true
	elif Input.is_action_pressed("Down") and Input.is_action_pressed("Left"):
		rotation_offset.rotation = deg_to_rad(135)  # Down-Left
		key_pressed = true
	elif Input.is_action_pressed("Up"):
		rotation_offset.rotation = deg_to_rad(270)
		key_pressed = true
	elif Input.is_action_pressed("Left"):
		rotation_offset.rotation = deg_to_rad(180)
		key_pressed = true
	elif Input.is_action_pressed("Right"):
		rotation_offset.rotation = deg_to_rad(0)
		key_pressed = true
	elif Input.is_action_pressed("Down"):
		rotation_offset.rotation = deg_to_rad(90)
		key_pressed = true
	
	#Rotation Input Through Mouse (only when no key is pressed)
	#if not key_pressed:
		#rotation_offset.rotation = lerp_angle(rotation_offset.rotation, (get_global_mouse_position() - global_position).angle(), 10*delta)
	#look_at(get_global_mouse_position())
	


func _on_rotation_offset_area_entered(_area: Area2D) -> void:
	Global.score += 1
	$HitSound.play()
	

func _on_game_manager_arduino_read(response: Variant) -> void:
	rotation_offset.rotation = deg_to_rad(response * speedRotation)
	print(rotation_offset.rotation_degrees)
