extends Area2D

@export var speed: float = 500.0
var direction: Vector2

func _process(delta):
	#Move Bullet
	position += direction * speed * delta

func set_direction(target: Vector2):
	direction = (target - global_position).normalized()
	rotation = direction.angle()  # Rotate bullet towards target

func _on_area_entered(_area: Area2D) -> void:
	queue_free()
