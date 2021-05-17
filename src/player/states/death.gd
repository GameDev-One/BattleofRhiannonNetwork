extends PlayerState

onready var dissolve = preload("res://src/vfx/dissolve/dissolve.tres")
var _time: float = 0.0

func enter(msg: = {}) -> void:
	_time = 0.0
	skin.transition_to(skin.States.IDLE)
	skin.mesh.set("material/0", dissolve)
	skin.mesh.set("material/1", dissolve)
	skin.mesh.set("material/2", dissolve)
	yield(get_tree().create_timer(2.0), "timeout")
	get_tree().reload_current_scene()
	
func physics_process(delta):
	_time += delta
	dissolve.set_shader_param("ScalarUniform", _time)
