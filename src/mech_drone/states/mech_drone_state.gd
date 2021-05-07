extends State
class_name MechDroneState

var mech_drone: MechDrone
var player: Player
var navigation: Navigation
var collision: RigidBody

func _ready() -> void:
	yield(owner, "ready")
	mech_drone = owner
	player = mech_drone.get_node(mech_drone.player)
	navigation = mech_drone.get_node(mech_drone.navigation)
