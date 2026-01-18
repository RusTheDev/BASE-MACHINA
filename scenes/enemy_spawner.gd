extends Node2D

@export var enemy_scene: PackedScene
@export var score_rate: int = 10
var last_triggered_score: int = -1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	@warning_ignore("unused_variable")
	enemy_spawn()

func _process(_delta: float) -> void:
	spawn_rate()

func spawn_rate() -> void:
	var current_score = Global.score 
	if current_score > 0 and current_score % score_rate == 0 and current_score != last_triggered_score:
		print("Spawning extra enemy.")
		enemy_spawn()
		last_triggered_score = current_score
	#if Global.score > 0 and Global.score % 7 == 0:
		#enemy_spawn()

func enemy_spawn() -> void:
	var new_enemy = enemy_scene.instantiate()
	add_child(new_enemy)
	new_enemy.visible = false
	await get_tree().create_timer(2.2).timeout
	new_enemy.visible = true
