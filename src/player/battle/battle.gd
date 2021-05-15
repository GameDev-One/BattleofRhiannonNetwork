extends PlayerState

func enter(msg := {}) -> void:
	if msg.has("chips") and msg["chips"]:
		_spawn_projectile(msg["chips"][0])
		_state_machine.transition_to("Move/Run")
	else:
		player.battle_setup_ui.open()
		yield(player.battle_setup_ui.anim, "animation_finished")
		Engine.time_scale = 0.1

func process(delta):
	if Input.is_action_just_pressed("ui_action2"):
		_state_machine.transition_to("Move/Run")
	

func exit() -> void:
	player.battle_setup_ui.close()
	Engine.time_scale = 1.0


func _spawn_projectile(chip: BattleChip) -> void:
	var instance = chip.projectile.instance()
	add_child(instance)
	instance.global_transform = player.muzzle.global_transform
	instance.damage = chip.damage
	instance.is_shot = true
