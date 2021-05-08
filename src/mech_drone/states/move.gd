extends MechDroneState

export var speed: float = 2

onready var points_of_interest: Array = get_tree().get_nodes_in_group("MechDronePOI")
var path: Array = []
var indexPOI: int = -1
var _random_index = -1

func _ready():
	randomize()
	connect_POI()

func enter(msg := {}) -> void:
	search_for_new_POI()
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

func connect_POI():
	for POI in points_of_interest:
		var err = POI.connect("body_entered", self, "_point_of_interest_reached")
		if err:
			print("Failed to connect.")
		
func _point_of_interest_reached(body: Node):
	if body == mech_drone:
		path = []
		_state_machine.transition_to("Idle")
	
func search_for_new_POI():
	while indexPOI == _random_index:
		_random_index = randi() % points_of_interest.size()
	indexPOI = _random_index
