extends PlayerState

func enter(msg := {}) -> void:
	Engine.time_scale = 0.1

func process(delta):
	if Input.is_action_just_pressed("ui_action2"):
		_state_machine.transition_to("Move/Run")

func exit() -> void:
	Engine.time_scale = 1.0
