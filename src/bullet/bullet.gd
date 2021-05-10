extends KinematicBody

const BULLET_VELOCITY = 20

export var explosion_force = 30

var time_alive = 5
var hit = false

onready var animation_player = $AnimationPlayer
onready var collision_shape = $CollisionShape

func _ready():
	set_as_toplevel(true)

func _physics_process(delta):
	if hit:
		return
	time_alive -= delta
	if time_alive < 0:
		hit = true
		animation_player.play("explode")
	var col = move_and_collide(-delta * BULLET_VELOCITY * transform.basis.z, false)
	if col:
		if col.collider and col.collider.is_in_group("Enemy"):
			col.collider.apply_central_impulse(-delta * explosion_force * transform.basis.z)
		collision_shape.disabled = true
		animation_player.play("explode")
		hit = true
