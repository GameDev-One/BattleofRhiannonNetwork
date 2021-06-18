extends CPUParticles


enum State{
	IDLE, 
	ALERT, 
	FOLLOW, 
	RETURN, 
	ATTACK,
	}

const IDLE = preload("res://assets/enemy/states/idle.png")
const ALERT = preload("res://assets/enemy/states/alert.png")
const FOLLOW = preload("res://assets/enemy/states/follow.png")

var textures: Array = [
	IDLE,
	ALERT,
	FOLLOW,
]


func emit_state(state: int) -> void:
	if state < textures.size():
		mesh.surface_get_material(0).albedo_texture = textures[state]
		restart()
		emitting = true
