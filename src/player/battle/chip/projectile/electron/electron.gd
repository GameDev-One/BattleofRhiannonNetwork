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
		for level in _body.get_children():
			if level is CPUParticles:
				level.emitting = true
			elif level is Sprite3D:
				continue
			else:
				level.emit = true


func _emit_anticipation() -> void:
	_anticipation.emitting = true
	for p in _anticipation.get_children():
		p.emitting = true
	yield(get_tree().create_timer(_anticipation.lifetime), "timeout")
	set_physics_process(true)


func _on_Electron_body_entered(body):
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
		_impact.global_transform.origin = _collision_pt
		_emit_impact()
	else:
		queue_free()


func _emit_impact() -> void:
	_impact.emitting = true
	yield(get_tree().create_timer(_anticipation.lifetime), "timeout")
	for p in _impact.get_children():
		p.emitting = true


func _on_Timer_timeout():
	queue_free()
