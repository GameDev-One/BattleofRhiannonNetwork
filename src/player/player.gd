tool
class_name Player
extends KinematicBody
# Helper class for the Player scene's scripts to be able to have access to the
# camera and its orientation.

onready var camera: CameraRig = $CameraRig
onready var skin: Mannequiny = $Mannequiny
onready var state_machine: StateMachine = $StateMachine

onready var joystick: Joystick = $UI/TouchControls/Joystick
onready var camera_stick: Joystick = $UI/TouchControls/Joystick2


func _get_configuration_warning() -> String:
	return "Missing camera node" if not camera else ""
