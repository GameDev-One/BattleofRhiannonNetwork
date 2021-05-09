tool
extends RigidBody
class_name MechDrone

export var player: NodePath
export var navigation: NodePath

onready var anim: AnimationPlayer = $AnimationPlayer
onready var state_machine: StateMachine = $StateMachine


func _get_configuration_warning() -> String:
	return "Missing player and navigation node" if not player and navigation else ""

