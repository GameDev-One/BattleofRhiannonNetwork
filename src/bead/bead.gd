extends RigidBody


export var speed: float = 10.0
export var damage: int = 1
var is_shot: bool = false


func _ready():
	set_as_toplevel(true)


func _physics_process(delta):
	if is_shot:
		apply_impulse(transform.basis.z, -transform.basis.z * speed)


func _on_Area_body_entered(body):
	if body.is_in_group("Enemy"):
		body.health -= damage
		queue_free()
