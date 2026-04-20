extends Label

func _process(_delta: float) -> void:
	self.text = str("High Score: ", Global.high_score)
