extends PlayerState

func enter(msg := {}) -> void:
	player.battle_setup_ui.open()
	yield(player.battle_setup_ui.anim, "animation_finished")
	Engine.time_scale = 0.1

func process(delta):
	if Input.is_action_just_pressed("ui_action2"):
		_state_machine.transition_to("Move/Run")
	

func exit() -> void:
	player.battle_setup_ui.close()
	Engine.time_scale = 1.0
