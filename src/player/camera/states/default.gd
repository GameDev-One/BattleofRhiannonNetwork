extends CameraState
# Rotates the camera around the character, delegating all the work to its parent state.


func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)
	
	if event.is_action_pressed("ui_action3"):
		_state_machine.transition_to("Camera/LockOn")


func process(delta: float) -> void:
	_parent.process(delta)
