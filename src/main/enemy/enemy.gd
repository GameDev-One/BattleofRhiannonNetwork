class_name Enemy
extends RigidBody

export(int, 1, 9999) var max_health: int = 1

var health: int = max_health

func _ready():
	if not is_in_group("Enemy"):
		add_to_group("Enemy")
		
func _process(delta):
	if health <= 0:
		queue_free()
