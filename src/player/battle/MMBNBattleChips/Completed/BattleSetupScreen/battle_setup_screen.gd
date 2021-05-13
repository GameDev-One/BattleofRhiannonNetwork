extends Control

const INIT_HAND_SIZE = 5

onready var folder: BattlechipFolder = preload("res://src/player/battle/MMBNBattleChips/Completed/BattlechipFolder/battlechip_folder.tres")
onready var info: Node = $BattleChipInfo
onready var selector: TextureRect = $BattlechipSelector
onready var hand: GridContainer = $BattlechipSelector/Hand

var _battle_fldr: BattlechipFolder = null


func _ready():
	_init_battle_fldr()
	hand.current_battlechip = 0
	info.display_battlechip(hand.slots_data[0])
	

func _init_battle_fldr():
	randomize()
	_battle_fldr = folder.duplicate()
	_battle_fldr.battlechips.shuffle()
	
	for index in INIT_HAND_SIZE:
		var battlechip = _battle_fldr.battlechips.pop_front()
		hand.set_slot(index, battlechip)


func _input(event):
	var index = hand.current_battlechip
	if event.is_action_pressed("ui_up"):
		if index - INIT_HAND_SIZE >= 0:
			hand.current_battlechip = index - INIT_HAND_SIZE
	elif event.is_action_pressed("ui_down"):
		if index + INIT_HAND_SIZE <= 9:
			hand.current_battlechip = index + INIT_HAND_SIZE
	elif event.is_action_pressed("ui_left"):
		if index - 1 >= 0 and index - 1 != 4:
			hand.current_battlechip = index - 1
	elif event.is_action_pressed("ui_right"):
		if index + 1 == 5 or index + 1 > 9:
			pass
		if index + 1 <= 9 and index + 1 != 5:
			hand.current_battlechip = index + 1
