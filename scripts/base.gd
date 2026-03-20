extends Area2D

@export var max_health: int = 10  # Maximum health
var current_health: int
@onready var health_bar: ProgressBar = $"../../Game UI/HealthBar"

func _ready():
	current_health = max_health  # Initialize health to max_health
	health_bar.value = current_health

func reduce_health(amount: int):
	current_health -= amount  # Subtract the damage amount
	current_health = max(current_health, 0)  # Ensure health doesn't go below 0
	health_bar.value = current_health
	if current_health <= 0:
		die()  # Call the die function if health reaches 0

func add_health(amount: int):
	current_health += amount  # Subtract the damage amount
	current_health = min(current_health, max_health)  # Ensure health doesn't go above 10
	health_bar.value = current_health

func die():
	print("Game Over!")  # Placeholder for when the object dies
	get_node("../../GameOver").game_over()
	queue_free()  # Remove the Area2D node from the scene

func _on_area_entered(area: Area2D) -> void:
	if area and area.is_in_group("bullets"):  # Ensure it's a valid object with the "collidable" group
		reduce_health(1)  # Adjust health reduction amount if needed
		area.queue_free()  # Remove the collided object from the scene
		$Hitsound.play()
	if area and area.is_in_group("health"):  # Ensure it's a valid object with the "collidable" group
		add_health(1)  # Adjust health reduction amount if needed
		area.queue_free()  # Remove the collided object from the scene
		$Healsound.play()
		
	
	
