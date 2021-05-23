extends TouchScreenButton

signal selected(index)

func _on_Slot_pressed():
	modulate = Color(1,1,1, .4)


func _on_Slot_released():
	modulate = Color(1,1,1, 1)
	emit_signal("selected", get_index())

func get_index() -> int:
	return name.lstrip("Slot").to_int() - 1
