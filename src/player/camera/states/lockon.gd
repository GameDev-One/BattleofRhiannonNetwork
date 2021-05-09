extends CameraState

export var lock_on_time: float = 0.15
onready var tween: Tween = $Tween
var _targets: Array = []

func enter(msg := {}) -> void:
	for body in camera_rig.player.lock_on_area.get_overlapping_bodies():
		if body.is_in_group("Enemy"):
			_targets.push_back(body)
	if not _targets.empty():
		_rotate_to_target()
		
	_state_machine.transition_to("Camera/Default")
	
func exit() -> void:
	_targets.clear()

func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)

func process(delta: float) -> void:
	_parent.process(delta)
	
func physics_process(delta) -> void:
	_parent.physics_process(delta)
	
func _rotate_to_target():
	var player_rot = camera_rig.player.global_transform.looking_at(_targets[0].global_transform.origin, Vector3.UP)
	var camera_rot = camera_rig.global_transform.looking_at(_targets[0].global_transform.origin, Vector3.UP)
#	var muzzle_rot = camera_rig.player.muzzle.global_transform.looking_at(_targets[0].global_transform.origin, Vector3.UP)
	
	tween.interpolate_property(camera_rig.player,
	"transform",
	camera_rig.player.global_transform,
	player_rot, 
	lock_on_time,
	Tween.TRANS_QUAD,
	Tween.EASE_OUT)
	
#	tween.interpolate_property(camera_rig.player.muzzle,
#	"transform",
#	camera_rig.player.muzzle.global_transform,
#	muzzle_rot, 
#	lock_on_time,
#	Tween.TRANS_QUAD,
#	Tween.EASE_OUT)
	
	tween.interpolate_property(
		camera_rig,
		"transform",
		camera_rig.global_transform,
		camera_rot,
		lock_on_time,
		Tween.TRANS_QUAD,
		Tween.EASE_OUT
	)
	
	tween.start()
