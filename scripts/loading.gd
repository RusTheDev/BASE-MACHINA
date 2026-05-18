extends CanvasLayer
@onready var shader: CanvasLayer = $"../../Shader"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.show()
	get_tree().paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Global.shader_toggle:
		shader.hide()
	else:
		shader.show()

func _on_timer_timeout() -> void:
	self.hide()
	get_tree().paused = false
