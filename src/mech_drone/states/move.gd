extends MechDroneState

export var speed: float = 2

onready var points_of_interest: Array = get_tree().get_nodes_in_group("MechDronePOI")
var path: Array = []
var indexPOI: int = -1

func _ready():
	randomize()

func enter(msg := {}) -> void:
	indexPOI = randi() % points_of_interest.size()
	mech_drone.look_at(points_of_interest[indexPOI].translation, Vector3.UP)

func physics_process(delta: float) -> void:
	if path.size() <= 0:
		path = navigation.get_simple_path(mech_drone.translation, 
										points_of_interest[indexPOI].translation, 
										true)
										
	var direction = Vector3()
	var step_amount = delta * speed
	
	if path.size() > 0:
		var destination = path[0]
		direction = destination - mech_drone.translation
		
		step_amount = clamp(step_amount, 0, direction.length())
		
		path.remove(0)
		
		mech_drone.translation += direction.normalized() * step_amount
		
