extends Node2D




func _process(_delta: float) -> void:
	if Input.is_action_pressed("main menu"):
		for bullet in get_tree().get_nodes_in_group("bullets"):  # Get all nodes in the "bullets" group
			bullet.queue_free()  # Remove bullets from the scene
		Global.score = 0  # Reset score if needed
		get_tree().change_scene_to_file("res://Menus/menu.tscn") 
		
