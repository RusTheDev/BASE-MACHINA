extends CharacterBody2D
#Fire Bullet
@export var bullet_scene: PackedScene = preload("res://scenes/bullet.tscn")
@export var fire_rate: float = 1.0

var fire_timer: float = 0.0
var can_shoot: bool = false  # Control shooting after delay
var target: Vector2 = Vector2 (0, 0)

#Movements of the spaceship
var radius: float = 515
var angle: float = 0.0
@export var speed: float = 1.5
var previous_position: Vector2

func _ready():
	previous_position = global_position
	# Wait 4 seconds before allowing shooting
	await get_tree().create_timer(4.0).timeout
	can_shoot = true

#Bullet Firing Logic
func _process(delta):
	#Detecting if it can shoot
	if not can_shoot:
		return  # Don't shoot yet
	
	#Fire rate
	fire_timer -= delta
	if fire_timer <= 0:
		fire_bullet()
		fire_timer = fire_rate * randf_range(0.7, 1.2) #randomised shooting rate
	

#Physics Movement
func _physics_process(_delta: float) -> void:
	move_character()
	

func move_character() -> void:
	angle += get_physics_process_delta_time() * speed
	var x_pos = cos(angle)
	var y_pos = sin(angle)
	
	position.x = radius * x_pos
	position.y = radius * y_pos
	
	var movement_vector = global_position - previous_position
	if movement_vector.length() > 0.001:
		rotation = movement_vector.angle()
	previous_position = global_position


func fire_bullet() -> void:
	#is_instance_valid(player)
	if bullet_scene and self.visible:
		var bullet = bullet_scene.instantiate()
		bullet.set_as_top_level(true)
		get_tree().get_root().add_child(bullet)  # Add to the scene
		bullet.global_position = global_position  # Start at enemy's position
		bullet.set_direction(target)  # Aim at player





#If player dies then removes the bullets
#func remove_bullets_when_player_freed():
	#if not is_instance_valid(player):  # Check if the player is no longer valid
		#var root = get_tree().get_root()  # Get the root of the scene
		#for child in root.get_children():
			#if child.is_in_group("bullets"):  # Replace 'Bullet' with the name/class of your bullet scene
				#child.queue_free()  # Remove the bullet
