tool
class_name Player
extends KinematicBody
# Helper class for the Player scene's scripts to be able to have access to the
# camera and its orientation.

signal health_changed(health)

onready var camera: CameraRig = $CameraRig
onready var skin: Godette = $Godette
onready var state_machine: StateMachine = $StateMachine

onready var joystick: Joystick = $UI/TouchControls/Joystick
onready var camera_stick: Joystick = $UI/TouchControls/Joystick2

onready var muzzle: Position3D = $Muzzle
onready var lock_on_area: Area = $LockOnArea
onready var damage_ind: CPUParticles = $DamageIndParticles

onready var battle_deck: Node = $BattleDeck

# Combat
export(String) var _c_Combat
export(int, 1, 9999) var max_health: int = 1
export(float, 0, 10) var chip_reload_time: float = 3.0

# Global
export(String) var _c_global
export(NodePath) var touch_action_ui_path: NodePath
onready var touch_action_ui: Array = get_node(touch_action_ui_path).get_children()

var health: int = 1 setget set_health
var is_invulnerable: bool = false

func _ready():
	set_health(max_health)

func _get_configuration_warning() -> String:
	return "Missing camera node" if not camera else ""

func set_health(value: int):
	if not is_invulnerable:
		health = value
		emit_signal("health_changed", health)
