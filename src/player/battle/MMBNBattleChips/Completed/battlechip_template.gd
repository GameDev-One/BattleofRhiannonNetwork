extends Control


onready var title: Label = $Frame/Title
onready var element: TextureRect = $Element
onready var rank: Label = $Frame/Rank
onready var damage: Label = $Frame/Damage
onready var image: TextureRect = $Image

func display_battlechip(battlechip: BattleChip):
	title.text = battlechip.name
	rank.text = battlechip.rank
	damage.text = str(battlechip.damage)
	image.texture = battlechip.full_image
	_set_element(battlechip.element)
	

func _set_element(element_type: int):
	match element_type:
		BattleChip.Element.ELEC:
			element.texture = load("res://Crafts/MMBNBattleChips/Assets/Elements/electric.png")
		BattleChip.Element.FIRE:
			element.texture = load("res://Crafts/MMBNBattleChips/Assets/Elements/fire.png")
		BattleChip.Element.NORMAL:
			element.texture = load("res://Crafts/MMBNBattleChips/Assets/Elements/normal.png")
		BattleChip.Element.AQUA:
			element.texture = load("res://Crafts/MMBNBattleChips/Assets/Elements/aqua.png")
		BattleChip.Element.WOOD:
			element.texture = load("res://Crafts/MMBNBattleChips/Assets/Elements/wood.png")