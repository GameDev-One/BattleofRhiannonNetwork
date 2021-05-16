class_name Enemy
extends RigidBody


signal health_changed()

export(int, 1, 9999) var max_health: int = 1
export(int, 1, 9999) var contact_damage: int = 10

var health: int = max_health setget set_health

func _ready():
	health = max_health
	connect("body_entered", self, "_on_body_entered")
	
	if not is_in_group("Enemy"):
		add_to_group("Enemy")
		
func _process(delta):
	if health <= 0:
		queue_free()
		
func set_health(value: int):
	health = value
	emit_signal("health_changed")

func _on_body_entered(body: Node):
	if body.is_in_group("Player"):
		body.health -= contact_damage
		body.damage_ind.value = contact_damage
