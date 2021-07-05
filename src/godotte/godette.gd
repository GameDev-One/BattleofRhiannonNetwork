extends Spatial
class_name Godette

enum States { IDLE, RUN, AIR, LAND, SHOOT }

onready var animation_tree: AnimationTree = $AnimationTree
onready var _playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]
onready var mesh: MeshInstance = $Armature/Skeleton/Mesh

var move_direction := Vector3.ZERO setget set_move_direction

func _ready():
	pass # Replace with function body.


func set_move_direction(direction: Vector3) -> void:
	move_direction = direction
	animation_tree["parameters/move_ground/blend_position"] = direction.length()
	

func current_animation_name() -> String:
	return _playback.get_current_node()
	
	
func transition_to(state_id: int) -> void:
	match state_id:
		States.IDLE:
			_playback.travel("idle")
		States.LAND:
			_playback.travel("land")
		States.RUN:
			_playback.travel("move_ground")
		States.AIR:
			_playback.travel("jump")
		States.SHOOT:
			_playback.travel("fight")
		_:
			_playback.travel("idle")
	
	
func get_animation_player() -> AnimationPlayer:
	return get_node("AnimationPlayer") as AnimationPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
