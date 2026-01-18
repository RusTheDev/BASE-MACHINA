extends Area2D

@export var speed: float = 500.0
var direction: Vector2
#var can_move := false  # Bullet starts paused

func _process(delta):
	#if can_move:
	position += direction * speed * delta  # Move bullet

func set_direction(target: Vector2):
	direction = (target - global_position).normalized()
	rotation = direction.angle()  # Rotate bullet towards target
	

func _on_area_entered(_area: Area2D) -> void:
	#print("Hit!")
	queue_free()
