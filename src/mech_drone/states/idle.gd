extends MechDroneState

onready var idle_time: Timer = $Timer

func enter(msg := {}) -> void:
	_parent.enter()
	idle_time.start()
	mech_drone.linear_velocity = Vector3.ZERO

func process(delta: float):
	if idle_time.is_stopped():
		_state_machine.transition_to("Move/Run")
