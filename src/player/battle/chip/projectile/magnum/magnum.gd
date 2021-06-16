extends Projectile


func _ready():
	set_as_toplevel(true)
	_emit_anticipation()


func _on_body_entered(body):
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


func _on_Lifetime_timeout():
	queue_free()


func _emit_anticipation() -> void:
	_anticipation.emitting = true
	for p in _anticipation.get_children():
		p.emitting = true


func _emit_impact() -> void:
	_impact.emitting = true
	for p in _impact.get_children():
		p.emitting = true
