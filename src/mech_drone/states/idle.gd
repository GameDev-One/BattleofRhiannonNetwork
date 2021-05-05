extends MechDroneState

onready var idle_time: Timer = $Timer

func enter(msg := {}) -> void:
	idle_time.start()

func process(delta: float):
	if idle_time.is_stopped():
		_state_machine.transition_to("Move")
