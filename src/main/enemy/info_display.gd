extends Sprite3D

onready var enemy: Enemy = get_parent()
onready var _viewport: Viewport = $Viewport
onready var health_bar: ProgressBar = $Viewport/HealthBar
onready var tween: Tween = $Tween

func _ready():
	texture = _viewport.get_texture()
	health_bar.hide()
	health_bar.max_value = enemy.max_health
	health_bar.value = enemy.max_health
	enemy.connect("health_changed", self, "_on_health_changed")


func _on_health_changed():
	health_bar.show()
	tween.interpolate_property(
		health_bar,
		"value", 
		health_bar.value, 
		enemy.health, 
		1.0,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN)
	tween.start()
