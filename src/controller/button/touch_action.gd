extends TouchScreenButton


export var wait_time = 3
export var pressed_color: Color = Color.gray
export var disabled_color: Color = Color.red
export(Texture) var static_texture = null

onready var RadialProgressBar: TextureProgress = $Control/TextureProgress
onready var Anim: AnimationPlayer = $AnimationPlayer

onready var _original_color : Color = self.modulate

var enabled: bool = false


func set_texture(t: Texture) -> void:
	RadialProgressBar.texture_progress = t


func restart() -> void:
	RadialProgressBar.max_value = wait_time
	RadialProgressBar.value = 0
	enabled = false
	set_process(true)


func _ready():
	if static_texture:
		RadialProgressBar.texture_progress = static_texture
		RadialProgressBar.value = wait_time
		
	
	RadialProgressBar.max_value = wait_time
	
	set_process(false)


func _on_TouchAction_pressed():
	if enabled or static_texture:
		self_modulate = pressed_color
	else:
		self_modulate = disabled_color


func _on_TouchAction_released():
	self_modulate = _original_color


func _process(delta):
	RadialProgressBar.value += delta
	
	if RadialProgressBar.value >= RadialProgressBar.max_value and not enabled:
		enabled = true
		Anim.play("flash")
