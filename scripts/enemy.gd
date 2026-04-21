extends CharacterBody2D
#Fire Bullet
@export var bullet_scene: PackedScene = preload("res://scenes/bullet.tscn")
@export var fire_rate: float = 1.0
@onready var ammo_bar: ProgressBar = $Polygon2D/ProgressBar
@export var explosionParticles: PackedScene

#Health
@export var health_scene: PackedScene = preload("res://scenes/health.tscn")

#Bullet
var fire_timer: float = 0.0
var can_shoot: bool = false 
var target: Vector2 = Vector2 (0, 0)
var ammo_count: int = 5

#Movements of the spaceship
var radius: float = 720
var angle: float = 0.0
@export var speed: float = 1.5
var previous_position: Vector2

#Asset Drawing
func _draw() -> void:
	var points = PackedVector2Array([ 
	Vector2(0, 0),
	Vector2(-80, -80),
	Vector2(-240, -80),
	Vector2(-160, 0),
	Vector2(-240, 80),
	Vector2(-80, 80),
	Vector2(0, 0),
	])
	
	var lineWidth: float = 16.0
	
	draw_polyline(points, Color.BLUE, lineWidth)
	draw_line(Vector2(0, 0), Vector2(-160, 0), Color.BLUE, lineWidth)
	pass

func _ready():
	angle = randf_range(0, TAU)
	previous_position = global_position
	# Wait 4 seconds before allowing shooting
	await get_tree().create_timer(4.0).timeout
	ammo_bar.value = ammo_count
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
	if not bullet_scene or not self.visible:
		return
	#Spawning a bullet
	object_spawn(bullet_scene)
	$Shoot.play()
	ammo_count -= 1
	ammo_bar.value = ammo_count
	if ammo_count <= 0:
		out_of_ammo()


func object_spawn(scene: PackedScene) -> void:
	var instance = scene.instantiate()
	instance.set_as_top_level(true)
	get_tree().root.add_child(instance)
	instance.global_position = self.global_position
	instance.set_direction(target)
	pass

func out_of_ammo() -> void:
	print("Ammo Run Out")
	explosionEffect(Color.BLUE)
	if health_scene:
		object_spawn(health_scene)
		
	queue_free() # Remove the enemy

func explosionEffect(color: Color):
	var effect = explosionParticles.instantiate()
	get_tree().current_scene.add_child(effect)
	effect.position = self.global_position
	effect.emitting = true
	effect.color = color

#func fire_bullet() -> void:
	#is_instance_valid(player)
	#if bullet_scene and self.visible:
		#var bullet = bullet_scene.instantiate()
		#bullet.set_as_top_level(true)
		#get_tree().get_root().add_child(bullet)  # Add to the scene
		#bullet.global_position = global_position  # Start at enemy's position
		#bullet.set_direction(target)  # Aim at player
		#ammo_count -= 1
		#if ammo_count == 0:
			#var health = health_scene.instantiate()
			#health.set_as_top_level(true)
			#get_tree().get_root().add_child(health)
			#bullet.global_position = global_position
			#health.set_direction(target)
			#queue_free()
			#print("Ammo Run Out")

#If player dies then removes the bullets
#func remove_bullets_when_player_freed():
	#if not is_instance_valid(player):  # Check if the player is no longer valid
		#var root = get_tree().get_root()  # Get the root of the scene
		#for child in root.get_children():
			#if child.is_in_group("bullets"):  # Replace 'Bullet' with the name/class of your bullet scene
				#child.queue_free()  # Remove the bullet
