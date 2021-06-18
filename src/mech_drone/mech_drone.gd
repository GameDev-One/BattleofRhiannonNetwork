tool
extends Enemy
class_name MechDrone

onready var anim: AnimationPlayer = $AnimationPlayer
onready var state_machine: StateMachine = $StateMachine

func _get_configuration_warning() -> String:
	return "Missing player and navigation node" if not player and navigation else ""
