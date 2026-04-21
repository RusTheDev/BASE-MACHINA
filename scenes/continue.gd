extends Label

@onready var timer: Timer = $"../Timer"

func _process(_delta: float) -> void:
	self.text = str("Continue? ", int(timer.time_left))
