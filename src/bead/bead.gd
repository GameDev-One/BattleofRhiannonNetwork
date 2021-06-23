extends RigidBody


export var speed: float = 10.0
export var damage: int = 1
var is_shot: bool = false


func _ready():
	set_as_toplevel(true)


func _physics_process(delta):
	if is_shot:
		apply_impulse(transform.basis.z, -transform.basis.z * speed)


func _on_Area_area_entered(area):
	if area.is_in_group("Enemy"):
		var body = area.get_parent()
		body.health -= damage
		body.dmg_ind_particles.value = damage
		queue_free()
	pass # Replace with function body.
