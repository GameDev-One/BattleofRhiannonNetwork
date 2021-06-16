extends Projectile


func _physics_process(delta):
	if is_shot:
		apply_impulse(transform.basis.z, -transform.basis.z * speed / 100)
		_emit_body()


func _emit_anticipation() -> void:
	if _anticipation:
		_anticipation.emitting = true
		for p in _anticipation.get_children():
			if p is CPUParticles:
				p.emitting = true


func _on_Incinerate_body_entered(body):
	if body.is_in_group("Enemy"):
		body.health -= damage
		body.dmg_ind_particles.value = damage
		_body.hide()
		_collision_shape.disabled = true
		_impact.global_transform.origin = _collision_pt
		_emit_impact()
	elif body.is_in_group("Wall"):
		_body.hide()
		_collision_shape.disabled = true
		_emit_impact()
	else:
		queue_free()
