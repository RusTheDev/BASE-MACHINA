extends CanvasLayer

func _ready() -> void:
	self.hide()

func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	Global.score = 0

func game_over():
	get_tree().paused = true
	remove_bullets()
	$GameOcerSound.play(1.47)
	self.show()

func remove_bullets():
	for bullet in get_tree().get_nodes_in_group("bullets"):  # Get all nodes in the "bullets" group
		bullet.queue_free()  # Remove the bullet from the scene

func _on_quit_pressed() -> void:
	get_tree().quit()
