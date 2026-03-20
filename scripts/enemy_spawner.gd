extends Node2D

#The Enemy
@export var enemy_scene: PackedScene

#Score Spawner Variables
@export var score_rate: int = 10
var last_triggered_score: int = -1

#Timer Spawner Variables
@onready var timer = $Timer
@export var min_range: float = 1.0
@export var max_range: float = 1.8

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_spawn_timer()
	enemy_spawn()

func _process(_delta: float) -> void:
	pass
	#spawn_rate_timer()
	#spawn_rate_score()

func start_spawn_timer() -> void:
	timer.wait_time = randf_range(min_range, max_range)
	timer.start()

func get_target_count() -> int:
	var score = Global.score
	if score >= 130: return 9
	if score >= 70:  return 7
	if score >= 30:  return 5
	return 4

func set_new_radius() -> float:
	var score = Global.score
	if score >= 130: return 400
	if score >= 70:  return 500
	if score >= 30:  return 600
	return 720

func _on_timer_timeout() -> void:
	var active_enemies = get_tree().get_nodes_in_group("enemies")
	var target = get_target_count()
	
	# Only spawn if we haven't hit the "cap" for our current score
	if active_enemies.size() < target:
		print("Population check: ", active_enemies.size(), "/", target, ". Spawning...")
		enemy_spawn()
	else:
		print("Population full. Skipping spawn.")
	# Always restart the timer so it checks again later
	start_spawn_timer()

#func spawn_rate_timer() -> void:
	#timer.wait_time = randf_range(min_range,max_range)
	#if timer.timeout:
		#print("Spawning extra enemy.")
		#enemy_spawn()

func spawn_rate_score() -> void:
	var current_score = Global.score 
	if current_score > 0 and current_score % score_rate == 0 and current_score != last_triggered_score:
		print("Spawning extra enemy.")
		enemy_spawn()
		last_triggered_score = current_score
	#if Global.score > 0 and Global.score % 7 == 0:
		#enemy_spawn()

func enemy_spawn() -> void:
	var new_enemy = enemy_scene.instantiate()
	new_enemy.radius = set_new_radius()
	add_child(new_enemy)
	new_enemy.visible = false
	await get_tree().create_timer(1.5).timeout
	new_enemy.visible = true
	$EnemySpawner.play()

#func _on_timer_timeout() -> void:
	#timer.wait_time = randf_range(min_range,max_range)
	#enemy_spawn()
	#pass # Replace with function body.
	
