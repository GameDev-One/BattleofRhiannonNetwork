extends PlayerState
# Basic state when the player is moving around until jumping or lack of input.


func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)

func process(delta: float) -> void:
	_parent.process(delta)

func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	if player.is_on_floor() or player.is_on_wall():
		if _parent.velocity.length() < 0.001:
			_state_machine.transition_to("Move/Idle")
	else:
		_state_machine.transition_to("Move/Air")


func enter(msg: = {}) -> void:
	skin.transition_to(skin.States.RUN)
	_parent.enter()


func exit() -> void:
	_parent.exit()
