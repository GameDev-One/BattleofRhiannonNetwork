extends Control


const INIT_HAND_SIZE = 5
const MAX_HAND_SIZE = 10

onready var folder: BattlechipFolder = preload("res://src/player/battle/MMBNBattleChips/Completed/BattlechipFolder/battlechip_folder.tres")

onready var anim: AnimationPlayer = $AnimationPlayer
onready var bg: Panel = $Bg

var _battle_fldr: BattlechipFolder = null
var _hand: Array = []
var _queued: Array = []


func _ready():
	_init_slots()
	_init_battle_fldr()
	_init_hand()
	_display_hand()
	


func open():
	anim.play("open")


func close():
	anim.play("close")
	

func add_battlechip():
	if _hand.size() < MAX_HAND_SIZE:
		var battlechip = _battle_fldr.battlechips.pop_front()
		_hand.push_back(battlechip)
		_display_hand()


func _init_slots():
	for slot in bg.get_children():
		slot.connect("selected", self, "_on_slot_selected")


func _init_hand():
	if _battle_fldr:
		for index in INIT_HAND_SIZE:
			var battlechip = _battle_fldr.battlechips.pop_front()
			_hand.push_back(battlechip)


func _init_battle_fldr():
	randomize()
	_battle_fldr = folder.duplicate()
	_battle_fldr.battlechips.shuffle()


func _display_hand():
	var slots: Array = bg.get_children()
	
	for slot in slots:
		slot.normal = null
		slot.pressed = null
	
	for index in _hand.size():
		if _hand[index]:
			slots[index + INIT_HAND_SIZE].normal = _hand[index].icon_image
			slots[index + INIT_HAND_SIZE].pressed = _hand[index].icon_image
		
	for index in _queued.size():
		slots[INIT_HAND_SIZE - index - 1].normal = _queued[index].icon_image
		slots[INIT_HAND_SIZE - index - 1].pressed = _queued[index].icon_image

func _on_slot_selected(index):
	var hand_index = index - INIT_HAND_SIZE
	if _queued.size() < INIT_HAND_SIZE:
		if _hand.size() >= hand_index and hand_index > -1:
			_queued.push_front(_hand[hand_index])
			_hand[hand_index] = null
			_display_hand()
	pass
