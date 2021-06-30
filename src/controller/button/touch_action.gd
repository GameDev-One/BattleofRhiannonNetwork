extends TouchScreenButton


export var wait_time = 3
export var pressed_color: Color = Color.white
export var disabled_color: Color = Color("3cffffff")
export(Texture) var static_texture = null

onready var RadialProgressBar: TextureProgress = $Control/TextureProgress
onready var Background: TextureProgress = $Bg
onready var Rank: Label = $Control/TextureProgress/TextureRect/Label
onready var Anim: AnimationPlayer = $AnimationPlayer
onready var Part: CPUParticles2D = $CPUParticles2D
onready var TimerLabel: Label = $Control/TimerLabel
onready var TimerLabelTime: Timer = $Control/TimerLabel/Timer

onready var _original_color : Color = self.modulate

var enabled: bool = false


func set_texture(t: Texture) -> void:
	RadialProgressBar.texture_progress = t


func set_rank(r: String) -> void:
	Rank.text = r
	
	if r == " ":
		Rank.get_parent().modulate = disabled_color


func restart() -> void:
	RadialProgressBar.max_value = wait_time
	RadialProgressBar.modulate = disabled_color
	RadialProgressBar.value = 0
	
	Background.max_value = wait_time
	Background.value = 0
	
	Rank.get_parent().modulate = disabled_color
	
	TimerLabel.text = str(wait_time).pad_decimals(1)
	TimerLabel.show()
	
	TimerLabelTime.start(wait_time)
	
	enabled = false
	set_process(true)


func _ready():
	if static_texture:
		RadialProgressBar.texture_progress = static_texture
		RadialProgressBar.value = wait_time
		Rank.get_parent().hide()
		Rank.hide()
		TimerLabel.hide()
		
	
	RadialProgressBar.max_value = wait_time
	Background.max_value = wait_time
	TimerLabel.text = " "
	
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
	Background.value += delta
	
	TimerLabel.text = str(TimerLabelTime.time_left).pad_decimals(1)
	
	if RadialProgressBar.value >= RadialProgressBar.max_value and not enabled:
		RadialProgressBar.modulate = Color.white
		Rank.get_parent().modulate = Color.white
		enabled = true
		TimerLabel.hide()
		Part.emitting = true
