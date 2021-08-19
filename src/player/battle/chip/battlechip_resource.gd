extends Resource
class_name BattleChip


enum Element{
	AQUA,
	ELEC,
	FIRE,
	NORMAL,
	WOOD,
}

export(String) var name = ""
export(Element) var element = Element.NORMAL
export(int, 0, 1000, 10) var damage = 0
export(Texture) var full_image = null
export(Texture) var icon_image = null
export(String) var rank = ''
export(PackedScene) var projectile = null
export(String, MULTILINE) var description = ""


func get_element_texture() -> Texture:
	var t: Texture
	match element:
		Element.AQUA:
			t = preload("res://assets/chip/Elements/aqua.png")
		Element.ELEC:
			t = preload("res://assets/chip/Elements/electric.png")
		Element.FIRE:
			t = preload("res://assets/chip/Elements/fire.png")
		Element.WOOD:
			t = preload("res://assets/chip/Elements/wood.png")
		Element.NORMAL:
			t = preload("res://assets/chip/Elements/normal.png")
		_:
			assert(false, "Invalid element assignment on chip: " + name)
	return t
