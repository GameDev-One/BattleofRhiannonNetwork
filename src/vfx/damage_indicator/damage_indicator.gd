extends Sprite3D

onready var _viewport: Viewport = $Viewport
onready var value_tag: Label = $Viewport/Text


func _ready():
	var new_texture = _viewport.get_texture()
	texture = new_texture
