extends TextureRect

onready var Name: Label = $Name
onready var Rank: Label = $Rank
onready var Damage: Label = $Damage
onready var Icon: TextureRect = $Icon

func update_ui(chip: BattleChip) -> void:
	Name.text = chip.name.left(11)
	Rank.text = chip.rank
	Damage.text = str(chip.damage)
	Icon.texture = chip.full_image
