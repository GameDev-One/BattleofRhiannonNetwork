extends PlayerState


var action_index: int = -1

var _previous_chip_rank: String = ""
var _combo_count: int = 0


func enter(msg := {}) -> void:
	
	var chip: BattleChip = null
	action_index = msg["action_index"]
	
	if action_index < 5 and action_index > 0 and player.touch_action_ui[action_index - 1].enabled:
		chip = player.battle_deck.get_chip(player.battle_deck.MAX_HAND_SIZE - action_index)
	elif action_index == 5:
		chip = player.battle_deck.get_next_chip()
		
	if not chip:
		_state_machine.transition_to("Move/Idle")
		return
		
	if chip.rank == _previous_chip_rank:
		_combo_count = posmod(_combo_count + 1, skin.MAX_COMBO_COUNT + 1)
		_shoot(chip, _combo_count)
	else:
		_combo_count = 0
		_shoot(chip, _combo_count)
		
	_previous_chip_rank = chip.rank
	
	yield(get_tree().create_timer(0.3), "timeout")
	
	_state_machine.transition_to("Move/Idle")


func process(delta):
	pass


func exit() -> void:
	pass

func _shoot(chip: BattleChip, combo_count: int) -> void:
	skin.set_current_battle_combo(_combo_count)
	skin.transition_to(skin.States.SHOOT)
	yield(get_tree().create_timer(0.2), "timeout")
	_spawn_projectile(chip)
	

func _spawn_projectile(chip: BattleChip) -> void:
	if chip:
		var instance = chip.projectile.instance()
		instance.global_transform = player.muzzle.global_transform
		instance.damage = chip.damage
		instance.is_shot = true
		add_child(instance)
		instance.global_transform = player.muzzle.global_transform
