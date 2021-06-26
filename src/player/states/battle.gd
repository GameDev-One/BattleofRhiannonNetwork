extends PlayerState


var action_index: int = -1


func enter(msg := {}) -> void:
	
	action_index = msg["action_index"]
	
	if action_index < 5 and player.touch_action_ui[action_index - 1].enabled:
		skin.transition_to(skin.States.SHOOT)
		yield(get_tree().create_timer(0.2), "timeout")
		_spawn_projectile(player.battle_deck.get_chip(player.battle_deck.MAX_HAND_SIZE - action_index))
	
	elif action_index == 5:
		skin.transition_to(skin.States.SHOOT)
		yield(get_tree().create_timer(0.2), "timeout")
		_spawn_projectile(player.battle_deck.get_next_chip())
	
	yield(get_tree().create_timer(0.3), "timeout")
	
	_state_machine.transition_to("Move/Idle")


func process(delta):
	pass


func exit() -> void:
	pass


func _spawn_projectile(chip: BattleChip) -> void:
	if chip:
		var instance = chip.projectile.instance()
		instance.global_transform = player.muzzle.global_transform
		instance.damage = chip.damage
		instance.is_shot = true
		add_child(instance)
		instance.global_transform = player.muzzle.global_transform
