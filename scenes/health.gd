@tool
extends Area2D

@export var hitParticles: PackedScene
@export var speed: float = 500.0
var direction: Vector2

func _draw():
	draw_rect(Rect2(0,-15,80,30), Color.GREEN)
	draw_rect(Rect2(25,-40,30,80), Color.GREEN)

func _process(delta):
	#Move Health Point
	position += direction * speed * delta

func set_direction(target: Vector2):
	direction = (target - global_position).normalized()
	rotation = direction.angle()  # Rotate bullet towards target

func _on_area_entered(_area: Area2D) -> void:
	var effect = hitParticles.instantiate()
	get_tree().current_scene.add_child(effect)
	effect.position = self.global_position
	effect.rotation = self.global_rotation + PI
	effect.emitting = true
	effect.color = Color(0.0, 1.0, 0.0, 1.0)
	queue_free()
