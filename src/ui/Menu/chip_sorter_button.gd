extends Button

onready var asc_ind: TextureRect = $Asc
onready var desc_ind: TextureRect = $Desc

func _on_ChipSorterButton_toggled(button_pressed):
	if button_pressed:
		asc_ind.show()
		desc_ind.hide()
	else:
		asc_ind.hide()
		desc_ind.show()
