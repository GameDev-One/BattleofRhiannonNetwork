extends Spatial
class_name MechDrone

export var player: NodePath
export var navigation: NodePath

onready var anim: AnimationPlayer = $AnimationPlayer
onready var collision: RigidBody = $RigidBody
