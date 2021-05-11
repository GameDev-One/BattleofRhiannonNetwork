class_name Enemy
extends RigidBody


signal health_changed()

export(int, 1, 9999) var max_health: int = 1

var health: int = max_health setget set_health

func _ready():
	health = max_health
	
	if not is_in_group("Enemy"):
		add_to_group("Enemy")
		
func _process(delta):
	if health <= 0:
		queue_free()
		
func set_health(value: int):
	health = value
	emit_signal("health_changed")
