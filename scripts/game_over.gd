extends CanvasLayer

var can_restart: bool = false
@onready var timer: Timer = $Timer
@onready var shader: CanvasLayer = $"../Shader"


func _ready() -> void:
	if not GameManager.ButtonPress.is_connected(button_pressed):
		GameManager.ButtonPress.connect(button_pressed)
	self.hide()
	can_restart = false

func _process(_delta: float) -> void:
	if not self.visible:
		return
	
	if Input.is_action_pressed("Start"):
		_on_retry_pressed()
	if Input.is_action_pressed("main menu"):
		_on_timer_timeout()
	if Global.shader_toggle:
		shader.hide()
	else:
		shader.show()


func button_pressed() -> void:
	if can_restart == true:
		_on_retry_pressed()

func _on_retry_pressed() -> void:
	if not is_inside_tree():
		return
	can_restart = false
	get_tree().paused = false
	get_tree().reload_current_scene()
	Global.score = 0

func game_over():
	get_tree().paused = true
	timer.start()
	can_restart = true
	remove_bullets()
	remove_health()
	$GameOcerSound.play(1.47)
	self.show()

func remove_bullets():
	for bullet in get_tree().get_nodes_in_group("bullets"):  
		bullet.queue_free()  

func remove_health():
	for bullet in get_tree().get_nodes_in_group("health"):  
		bullet.queue_free()

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_timer_timeout() -> void:
	remove_bullets()
	remove_health()
	get_tree().paused = false
	Global.score = 0
	get_tree().change_scene_to_file("res://Menus/menu.tscn") 
