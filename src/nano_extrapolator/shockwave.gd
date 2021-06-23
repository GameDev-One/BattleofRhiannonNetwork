extends CPUParticles

onready var collision: CollisionShape = $AttackRange/CollisionShape

func activate_collision(b: bool) -> void:
	collision.disabled = !b
