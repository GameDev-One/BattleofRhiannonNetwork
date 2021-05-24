extends CameraState

export var lock_on_time: float = 0.15
export var side_rot_degree: float = 30
onready var tween: Tween = $Tween
var _targets: Array = []

func sort_closest(a, b):
		var a_distance_from_player = camera_rig.player.global_transform.origin - a.global_transform.origin
		var b_distance_from_player = camera_rig.player.global_transform.origin - b.global_transform.origin
		if a_distance_from_player < b_distance_from_player:
			return true
		return false
		
func enter(msg := {}) -> void:
	for body in camera_rig.player.lock_on_area.get_overlapping_bodies():
		if body.is_in_group("Enemy"):
			_targets.push_back(body)
	if not _targets.empty():
		_targets.sort_custom(self, "sort_closest")
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
	if not _targets.empty():
		camera_rig.aim_target.visible = true
		camera_rig.aim_target.global_transform.origin = _targets[0].global_transform.origin
	
	var bodies = camera_rig.player.lock_on_area.get_overlapping_bodies()
	var potiential_targets = []
	for body in bodies:
		if body.is_in_group("Enemy"):
			potiential_targets.push_back(body)

	if potiential_targets.empty():
		_state_machine.transition_to("Camera/Default")
	else:
		_targets.sort_custom(self, "sort_closest")
		_rotate_to_target()
			
func _rotate_to_target():
	var player_rot = camera_rig.player.global_transform.looking_at(_targets[0].global_transform.origin, Vector3.UP)
	
	var midpoint: Vector3 = _calc_midpoint(_targets[0].global_transform.origin, camera_rig.player.global_transform.origin)
	var camera_rot = camera_rig.global_transform.looking_at(midpoint, Vector3.UP)
	
	var side_degree: float = side_rot_degree
	if _is_left_of_target(camera_rig.player.global_transform.origin, _targets[0].global_transform.origin):
		side_degree *= -1
	
	tween.interpolate_property(camera_rig.player,
	"transform",
	camera_rig.player.global_transform,
	player_rot, 
	0.001,
	Tween.TRANS_QUAD,
	Tween.EASE_OUT)
	
	tween.interpolate_property(
		camera_rig,
		"transform",
		camera_rig.global_transform,
		camera_rot.rotated(Vector3.UP, deg2rad(side_degree)),
		lock_on_time,
		Tween.TRANS_QUAD,
		Tween.EASE_OUT
	)
	
	tween.start()


func _calc_midpoint(a: Vector3, b: Vector3) -> Vector3:
	return Vector3((a.x + b.x) / 2, (a.y + b.y) / 2, (a.z + b.z) / 2)
	
func _is_left_of_target(a: Vector3, b: Vector3) -> bool:
	return false if a.direction_to(b).x > 0 else true
