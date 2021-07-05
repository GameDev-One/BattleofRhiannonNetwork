extends PlayerState


var action_index: int = -1

var _previous_chip_rank: String = ""
var _combo_count: int = 0


func enter(msg := {}) -> void:
	
	action_index = msg["action_index"]
	
	if player.touch_action_ui[action_index - 1].enabled:
		var chip = player.battle_deck.get_chip(player.battle_deck.MAX_HAND_SIZE - action_index)
		if chip.rank == _previous_chip_rank:
			_combo_count = posmod(_combo_count + 1, skin.MAX_COMBO_COUNT + 1)
			skin.set_current_battle_combo(_combo_count)
			skin.transition_to(skin.States.SHOOT)
			yield(get_tree().create_timer(0.2), "timeout")
			_spawn_projectile(chip)
		else:
			_combo_count = 0
			skin.set_current_battle_combo(_combo_count)
			skin.transition_to(skin.States.SHOOT)
			yield(get_tree().create_timer(0.2), "timeout")
			_spawn_projectile(chip)
		_previous_chip_rank = chip.rank
	
	elif action_index == 5:
		var chip = player.battle_deck.get_next_chip()
		if chip.rank == _previous_chip_rank:
			_combo_count = posmod(_combo_count + 1, skin.MAX_COMBO_COUNT + 1)
			skin.set_current_battle_combo(_combo_count)
			skin.transition_to(skin.States.SHOOT)
			yield(get_tree().create_timer(0.2), "timeout")
			_spawn_projectile(chip)
		else:
			_combo_count = 0
			skin.set_current_battle_combo(_combo_count)
			skin.transition_to(skin.States.SHOOT)
			yield(get_tree().create_timer(0.2), "timeout")
			_spawn_projectile(chip)
		_previous_chip_rank = chip.rank
	
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
