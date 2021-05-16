tool
class_name Player
extends KinematicBody
# Helper class for the Player scene's scripts to be able to have access to the
# camera and its orientation.

signal health_changed(health)

onready var camera: CameraRig = $CameraRig
onready var skin: Mannequiny = $Mannequiny
onready var state_machine: StateMachine = $StateMachine

onready var joystick: Joystick = $UI/TouchControls/Joystick
onready var camera_stick: Joystick = $UI/TouchControls/Joystick2

onready var muzzle: Position3D = $Muzzle
onready var lock_on_area: Area = $LockOnArea

onready var battle_setup_ui: Control = $UI/TouchControls/BattleSetupScreen

export(int, 1, 9999) var max_health: int = 1

var health: int = 1 setget set_health

func _ready():
	set_health(max_health)

func _get_configuration_warning() -> String:
	return "Missing camera node" if not camera else ""

func set_health(value: int):
	health = value
	emit_signal("health_changed", health)
