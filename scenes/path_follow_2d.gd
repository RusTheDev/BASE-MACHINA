extends PathFollow2D

@export var speed = 0.2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_ratio += delta * speed
	pass
