extends CPUParticles

export var value: int = 0 setget set_value

onready var dmg_ind_sprite: Sprite3D = $DamageInd

func _ready():
	var mat = mesh.surface_get_material(0)
	mat.albedo_texture = dmg_ind_sprite.texture
	pass

func set_value(new_value: int):
	value = new_value
	dmg_ind_sprite.value_tag.text = str(new_value)
	var mat = mesh.surface_get_material(0)
	mat.albedo_texture = dmg_ind_sprite.texture
	restart()

