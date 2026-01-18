extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.show()
	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	self.hide()
	get_tree().paused = false
