extends State
class_name NanoExtrapolatorState

var nano_extplr: NanoExtrapolator
var _player: Player
var _navigation: Navigation
var _origin_pt: Vector3 = Vector3()

var agent: GSAIKinematicBody3DAgent
var target: GSAIAgentLocation
var accel: GSAITargetAcceleration
var blend: GSAIBlend
var face: GSAIFace
var arrive: GSAIArrive
var target_node: Spatial

func _ready():
	yield(owner, "ready")
	nano_extplr = owner
	_player = nano_extplr.player
	_navigation = nano_extplr.navigation
	agent = GSAIKinematicBody3DAgent.new(nano_extplr)
	target = GSAIAgentLocation.new()
	accel = GSAITargetAcceleration.new()
	blend = GSAIBlend.new(agent)
	face = GSAIFace.new(agent, target, true)
	arrive = GSAIArrive.new(agent, target)
	
	setup(deg2rad(nano_extplr.align_tolerance),
		deg2rad(nano_extplr.angular_deceleration_radius),
		deg2rad(nano_extplr.angular_accel_max),
		deg2rad(nano_extplr.angular_speed_max),
		nano_extplr.deceleration_radius,
		nano_extplr.arrival_tolerance,
		nano_extplr.linear_acceleration_max,
		nano_extplr.linear_speed_max,
		_player as Spatial)


func setup(
	align_tolerance: float,
	angular_deceleration_radius: float,
	angular_accel_max: float,
	angular_speed_max: float,
	deceleration_radius: float,
	arrival_tolerance: float,
	linear_acceleration_max: float,
	linear_speed_max: float,
	_target: Spatial
) -> void:
	agent.linear_speed_max = linear_speed_max
	agent.linear_acceleration_max = linear_acceleration_max
	agent.linear_drag_percentage = 0.05
	agent.angular_acceleration_max = angular_accel_max
	agent.angular_speed_max = angular_speed_max
	agent.angular_drag_percentage = 0.1

	arrive.arrival_tolerance = arrival_tolerance
	arrive.deceleration_radius = deceleration_radius

	face.alignment_tolerance = align_tolerance
	face.deceleration_radius = angular_deceleration_radius

	target_node = _target
	self.target.position = target_node.transform.origin
	blend.add(arrive, 1)
	blend.add(face, 1)
