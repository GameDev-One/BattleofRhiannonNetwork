extends Resource
class_name BattlechipFolder
"""
# file		battlechip_folder_resource.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		16 JUL 2021
# copyright	Copyright (c) 2021 GameDevone
# brief		Resurces used to interface with a group of battlechips.
"""

signal battlechips_changed(indexes)

const MAX_SIZE = 40

export(Array, Resource) var battlechips = [
	null, null, null, null, null, 
	null, null, null, null, null,
	null, null, null, null, null,
	null, null, null, null, null,
	null, null, null, null, null,
	null, null, null, null, null,
	null, null, null, null, null,
	null, null, null, null, null
	]


class BattlechipSorter:
	static func sort_name_asc(a: BattleChip, b: BattleChip):
		if a.name < b.name:
			return true
		return false
		
	static func sort_name_desc(a: BattleChip, b: BattleChip):
		if a.name > b.name:
			return true
		return false
		
	static func sort_element_asc(a: BattleChip, b: BattleChip):
		if a.element < b.element:
			return true
		return false
		
	static func sort_element_desc(a: BattleChip, b: BattleChip):
		if a.element > b.element:
			return true
		return false
		
	static func sort_rank_asc(a: BattleChip, b: BattleChip):
		if a.rank < b.rank:
			return true
		return false
		
	static func sort_rank_desc(a: BattleChip, b: BattleChip):
		if a.rank > b.rank:
			return true
		return false
		
	static func sort_dmg_asc(a: BattleChip, b: BattleChip):
		if a.damage < b.damage:
			return true
		return false
		
	static func sort_dmg_desc(a: BattleChip, b: BattleChip):
		if a.damage > b.damage:
			return true
		return false


func set_battlechip(index: int, battlechip: BattleChip) -> BattleChip:
	var previous_battlechip = battlechips[index]
	battlechips[index] = battlechip
	emit_signal("battlechips_changed", [index])
	return previous_battlechip


func remove_battlechip(index: int) -> BattleChip:
	var previous_battlechip = battlechips[index]
	battlechips[index] = null
	emit_signal("battlechips_changed", [index])
	return previous_battlechip


func swap_battlechips(index, target_index) -> void:
	var target_battlechip = battlechips[target_index]
	var battlechip = battlechips[index]
	battlechips[target_index] = battlechip
	battlechips[index] = target_battlechip
	emit_signal("battlechips_changed",[index, target_index])


func pop() -> BattleChip:
	return battlechips.pop_front()


func push(b: BattleChip):
	if battlechips.size() < MAX_SIZE:
		battlechips.push_front(b)


func is_empty() -> bool:
	return battlechips.empty()


func peek() -> BattleChip:
	return battlechips.front()


func sort_by_name_asc():
	battlechips.sort_custom(BattlechipSorter, "sort_name_asc")

func sort_by_name_desc():
	battlechips.sort_custom(BattlechipSorter, "sort_name_desc")

func sort_by_element_asc():
	battlechips.sort_custom(BattlechipSorter, "sort_element_asc")

func sort_by_element_desc():
	battlechips.sort_custom(BattlechipSorter, "sort_element_desc")

func sort_by_rank_asc():
	battlechips.sort_custom(BattlechipSorter, "sort_rank_asc")

func sort_by_rank_desc():
	battlechips.sort_custom(BattlechipSorter, "sort_rank_desc")

func sort_by_dmg_asc():
	battlechips.sort_custom(BattlechipSorter, "sort_dmg_asc")

func sort_by_dmg_desc():
	battlechips.sort_custom(BattlechipSorter, "sort_dmg_desc")
