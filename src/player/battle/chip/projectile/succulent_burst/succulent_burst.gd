extends Projectile

func _ready():
	set_as_toplevel(true)
	set_physics_process(false)
	_emit_anticipation()
	

func _physics_process(delta):
	if is_shot:
		apply_impulse(transform.basis.z, -transform.basis.z * speed / 100)
		is_shot = false
		_body.emitting = true
#		_trail.emitting = true


func _emit_anticipation() -> void:
	_anticipation.emitting = true
	yield(get_tree().create_timer(_anticipation.lifetime), "timeout")
	set_physics_process(true)


func _on_SucculentBurst_body_entered(body):
	if body.is_in_group("Enemy"):
		body.health -= damage
		body.dmg_ind_particles.value = damage
		_collision_shape.disabled = true
		_body.hide()
		_impact.global_transform.origin = _collision_pt
		_emit_impact()
	else:
		queue_free()


func _on_Lifetime_timeout():
	queue_free()
