extends Node
"""
# file		battle_deck.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		23 JUN 2021
# copyright	Copyright (c) 2021 GameDevone
# brief		Controller for player's chip abilties
"""


const MAX_HAND_SIZE = 4

export(Resource) var chip_deck_resource = null

onready var player: Player = get_parent()
onready var ReloadTimer: Timer = $Reload

var hand: Array = [null, null, null, null]


func _ready():
	yield(owner, "ready")
	
	ReloadTimer.wait_time = player.chip_reload_time
	ReloadTimer.start()
	
	randomize()
	chip_deck_resource.battlechips.shuffle()
	
	draw_next_chip()


func get_chip(i: int) -> BattleChip:
	var next_chip = hand[i]
	hand[i] = null
	update_ui()
	return next_chip


func get_next_chip() -> BattleChip:
	for i in MAX_HAND_SIZE:
		if hand[i] and player.touch_action_ui[MAX_HAND_SIZE - i - 1].enabled:
			return get_chip(i)
	return null


func is_card_available() -> bool:
	for i in MAX_HAND_SIZE:
		if hand[i] and player.touch_action_ui[MAX_HAND_SIZE - i - 1].enabled:
			return true
	return false


func draw_next_chip() -> void:
	var empty_space_index = hand.find(null)
	if empty_space_index > -1:
		hand[empty_space_index] = chip_deck_resource.pop()
		player.touch_action_ui[MAX_HAND_SIZE - empty_space_index - 1].restart()
		update_ui()


func update_ui() -> void:
	for i in MAX_HAND_SIZE:
		if hand[MAX_HAND_SIZE - i - 1]:
			player.touch_action_ui[i].set_texture(hand[MAX_HAND_SIZE - i - 1].full_image)
			player.touch_action_ui[i].set_rank(hand[MAX_HAND_SIZE - i - 1].rank)
		else:
			player.touch_action_ui[i].set_texture(null)
			player.touch_action_ui[i].set_rank(" ")
			


func _on_Reload_timeout():
	draw_next_chip()
