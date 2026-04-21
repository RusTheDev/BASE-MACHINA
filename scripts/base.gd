extends Area2D

@export var max_health: int = 12  # Maximum health
var current_health: int
@onready var left: ProgressBar = $Left
@onready var right: ProgressBar = $Right
@onready var leftTop: ProgressBar = $Left/Left
@onready var rightTop: ProgressBar = $Right/Right
@export var explosionParticles: PackedScene

func _ready():
	current_health = max_health  # Initialize health to max_health
	left.value = current_health
	right.value = current_health
	leftTop.value = current_health
	rightTop.value = current_health
	print("Current Health: ",current_health)

func reduce_health(amount: int):
	current_health -= amount  # Subtract the damage amount
	current_health = max(current_health, 0)  # Ensure health doesn't go below 0
	
	left.value = current_health
	right.value = current_health
	leftTop.value = current_health
	rightTop.value = current_health
	if current_health <= 0:
		die()  # Call the die function if health reaches 0

func add_health(amount: int):
	current_health += amount  # Subtract the damage amount
	current_health = min(current_health, max_health)  # Ensure health doesn't go above 10
	
	left.value = current_health
	right.value = current_health
	leftTop.value = current_health
	rightTop.value = current_health

func die():
	print("Game Over!")  # Placeholder for when the object dies
	get_node("../../GameOver").game_over()
	queue_free()  # Remove the Area2D node from the scene

func _on_area_entered(area: Area2D) -> void:
	if area and area.is_in_group("bullets"):  # Ensure it's a valid object with the "collidable" group
		reduce_health(1)  # Adjust health reduction amount if needed
		area.queue_free()  # Remove the collided object from the scene
		$Hitsound.play()
		explosionEffect(Color.RED)
		print("Current Health: ",current_health)
	if area and area.is_in_group("health"):  # Ensure it's a valid object with the "collidable" group
		add_health(1)  # Adjust health reduction amount if needed
		area.queue_free()  # Remove the collided object from the scene
		$Healsound.play()
		explosionEffect(Color.GREEN)
		print("Current Health: ",current_health)

func explosionEffect(color: Color):
	var effect = explosionParticles.instantiate()
	get_tree().current_scene.add_child(effect)
	effect.position = self.global_position
	effect.emitting = true
	effect.color = color
