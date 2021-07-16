extends Button
class_name Scroll_Button


onready var chip_name: Label = $Bg/HBoxContainer/Name
onready var chip_damage: Label = $Bg/HBoxContainer/Damage
onready var chip_element: TextureRect = $Bg/HBoxContainer/Element
onready var chip_rank: Label = $Bg/HBoxContainer/Rank
onready var box_cursor: NinePatchRect = $BoxCursor

var just_pressed = false
var prev_pos

var threshold = 5

signal scroll_button_pressed(index)


func update_ui(chip: BattleChip) -> void:
	chip_name.text = chip.name
	chip_damage.text = str(chip.damage)
	chip_rank.text = chip.rank
	chip_element.texture = chip.get_element_texture()


func _ready():
	connect("gui_input", self, "_on_Button_gui_input")
	
	mouse_filter = MOUSE_FILTER_PASS


func _on_Button_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			just_pressed = true
			prev_pos = event.position
			
		if not event.pressed and just_pressed and event.position.distance_to(prev_pos) < threshold:
			just_pressed = false
			emit_signal("scroll_button_pressed", get_index())
			box_cursor.visible = true
