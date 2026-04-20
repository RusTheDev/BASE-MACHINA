extends Node

var score = 0
var high_score = 0

func _process(_delta: float) -> void:
	_high_score()

func _high_score() -> void:
	if score > high_score:
		high_score = score
