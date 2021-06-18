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

export(float) var turn_speed: float = 15

onready var Cooldown: Timer = $Timer


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
	nano_extplr.state_display.emit_state(nano_extplr.state_display.State.ALERT)
	Cooldown.start()
	


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
	pass


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


func _on_Timer_timeout():
		_state_machine.transition_to("Follow")


func _on_Area_body_exited(body):
	if _state_machine.state == self:
		if body.is_in_group("Player"):
			Cooldown.stop()
			_state_machine.transition_to("Idle")
	pass # Replace with function body.
