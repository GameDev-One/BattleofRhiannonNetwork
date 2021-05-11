extends Sprite3D

onready var enemy: RigidBody = get_parent()
onready var _viewport: Viewport = $Viewport
onready var health_bar: ProgressBar = $Viewport/HealthBar

func _ready():
	texture = _viewport.get_texture()
	health_bar.hide()
	health_bar.max_value = enemy.max_health
	health_bar.value = enemy.max_health
	enemy.connect("health_changed", self, "_on_health_changed")


func _on_health_changed():
	health_bar.show()
	health_bar.value = enemy.health
