extends RigidBody


export var speed: float = 10.0
export var damage: int = 1

onready var _anticipation: CPUParticles = $Anticipation
onready var _body: CPUParticles = $Body
onready var _impact: CPUParticles = $Impact

onready var _lifetime: Timer = $Lifetime

var is_shot: bool = false


func _ready():
	set_as_toplevel(true)
	_emit_anticipation()


func _physics_process(delta):
	if is_shot:
		apply_impulse(transform.basis.z, -transform.basis.z * speed / 100)
		is_shot = false


func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		body.health -= damage
		body.dmg_ind_particles.value = damage
		_body.hide()
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
#	yield(get_tree().create_timer(_impact.lifetime), "timeout")
	for p in _impact.get_children():
		p.emitting = true
