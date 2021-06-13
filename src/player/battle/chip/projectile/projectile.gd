class_name Projectile
extends RigidBody

export var speed: float = 10.0

export(NodePath) var collision_shape
export(NodePath) var anticipation_path
export(NodePath) var body_path
export(NodePath) var impact_path

onready var _collision_shape: CollisionShape = get_node(collision_shape)
onready var _anticipation: CPUParticles = get_node(anticipation_path)
onready var _body: CPUParticles = get_node(body_path)
onready var _impact: CPUParticles = get_node(impact_path)

var damage: int = 0
var is_shot: bool = false

var _collision_pt: Vector3 = Vector3()


func _ready():
	set_as_toplevel(true)
	_emit_anticipation()


func _physics_process(delta):
	if is_shot:
		apply_impulse(transform.basis.z, -transform.basis.z * speed / 100)

func _integrate_forces(state):
	if state.get_contact_count():
		_collision_pt = state.get_contact_collider_position(0)


func _emit_anticipation() -> void:
	_anticipation.emitting = true
	for p in _anticipation.get_children():
		p.emitting = true


func _emit_impact() -> void:
	_impact.emitting = true
	for p in _impact.get_children():
		p.emitting = true
