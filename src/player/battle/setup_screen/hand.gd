extends GridContainer

onready var slots: Array = get_children()
onready var current_battlechip: int = -1 setget _set_current_battlechip
var slots_data: Array = [
	null, null, null, null, null,
	null, null, null, null, null
						]


func set_slot(index: int, battlechip: BattleChip):
	slots[index].texture_normal = battlechip.full_image
	slots[index].get_node("Rank").text = battlechip.rank
	slots_data[index] = battlechip

func _set_current_battlechip(index: int):
	current_battlechip = index
	for chip in slots:
		chip.stop()
		
	slots[index].play()
