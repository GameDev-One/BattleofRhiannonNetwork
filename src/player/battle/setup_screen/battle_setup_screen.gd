extends Control


const INIT_HAND_SIZE = 5
const MAX_HAND_SIZE = 10

export(float, 0.1, 999) var chip_refresh_time = 2.0

onready var folder: BattlechipFolder = preload("res://src/player/battle/chip_fldr/chip_fldr.tres")

onready var anim: AnimationPlayer = $AnimationPlayer
onready var bg: Panel = $Bg
onready var timer_display: Label = $Bg/TimerDisplay
onready var timer: Timer = $Bg/TimerDisplay/Timer
onready var overlay: ColorRect = $Bg/Overlay

var _battle_fldr: BattlechipFolder = null
var _hand: Array = []
var _queued: Array = []


func _ready():
	_init_slots()
	_init_battle_fldr()
	_init_hand()
	_init_timer()
	_display_hand()
	
	
func _process(delta):
	display_timer()


func open():
	timer.stop()
	_display_hand()
	anim.play("open")


func close():
	anim.play("close")


func add_battlechip():
	if _hand.size() < MAX_HAND_SIZE:
		var battlechip = _battle_fldr.battlechips.pop_front()
		_hand.push_back(battlechip)
		_display_hand()


func is_queued_empty() -> bool:
	return _queued.empty()


func get_queued() -> Array:
	return [] if is_queued_empty() else _queued


func _init_slots():
	for slot in bg.get_children():
		if slot is TouchScreenButton:
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


func _init_timer():
	timer.wait_time = chip_refresh_time
	timer.start()


func display_timer():
	timer_display.show()
	overlay.show()
	
	if timer.time_left <= 0:
		timer_display.hide()
		overlay.hide()
		
	timer_display.text = str(stepify(timer.time_left, 0.1))


func _display_hand():
	var slots: Array = bg.get_children()
	
	for slot in slots:
		if slot is TouchScreenButton:
			slot.normal = null
			slot.pressed = null
	
	for index in _hand.size():
		if _hand[index]:
			slots[index + INIT_HAND_SIZE].normal = _hand[index].icon_image
			slots[index + INIT_HAND_SIZE].pressed = _hand[index].icon_image
		
	for index in _queued.size():
		slots[index].normal = _queued[index].icon_image
		slots[index].pressed = _queued[index].icon_image


func _on_slot_selected(index):
	var hand_index = index - INIT_HAND_SIZE
	if _queued.size() < INIT_HAND_SIZE:
		if _hand.size() >= hand_index and hand_index > -1:
			_queued.push_front(_hand[hand_index])
			_hand[hand_index] = null
			_display_hand()


func _on_Timer_timeout():
	add_battlechip()
