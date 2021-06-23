extends NanoExtrapolatorState
"""
# file		default_state.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		17 MAY 2021
# copyright	Copyright (c) 2021 GameDevone
# brief		Contains boilerplate code and comments for follwing the coding style
			guide.
# note		This can be accessed when creating a new script and clicking the 
			templates option.
"""


"""
# brief		Called when the node is 'ready', i.e. when both the node and its 
			children have entered the scene tree.
"""
func _ready() -> void:
	pass


"""
# brief		Called when object is transitioned to this state.
# param msg	Additional varibales passed along to the requested state.
"""
func enter(msg := {}) -> void:
	nano_extplr.state_display.emit_state(nano_extplr.state_display.State.RETURN)
	pass
	


"""
# brief		Called as the object is transitioned out of this state.
"""
func exit() -> void:
	pass


"""
# brief			Called during the physics processing step of the main loop. 
				Physics processing means that the frame rate is synced to the 
				physics, i.e. the delta variable should be constant.
# param delta
				Amount of time that has passed since last call to 
				_physics_process.
"""
func physics_process(delta: float) -> void:
	target.position = _origin_pt
	target.position.y = nano_extplr.transform.origin.y
	blend.calculate_steering(accel)
	agent._apply_steering(accel, delta)
	
	var dist_to_origin = nano_extplr.global_transform.origin.distance_to(_origin_pt)
	if dist_to_origin < nano_extplr.arrival_tolerance:
		_state_machine.transition_to("Idle")


"""
# brief			Called during the processing step of the main loop. Processing 
				happens at every frame and as fast as possible, so the delta 
				time since the previous frame is not constant.
# param delta
				Amount of time that has passed since last call to _process.
"""
func process(delta: float) -> void:
	pass


"""
# brief			Called when an InputEvent hasn't been consumed by _input() or 
				any GUI.
# param event
				Input event that occured.
"""
func unhandled_input(event: InputEvent) -> void:
	pass
