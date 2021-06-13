extends Spatial

export(Array, PackedScene) var projectiles

onready var Muzzle: Spatial = $Muzzle

var _index = 0

func _input(event):
	if event.is_action_pressed("ui_accept"):
		_spawn_bullet(0)
	elif event.is_action_pressed("ui_left"):
		_index -= 1
		if _index < 0:
			_index = 0
	elif event.is_action_pressed("ui_right"):
		_index += 1
		if _index > projectiles.size() - 1:
			_index = projectiles.size() - 1


func _spawn_bullet(addtl_damage: int = 0) -> void:
	var instance = projectiles[_index].instance()
	add_child(instance)
	instance.global_transform = Muzzle.global_transform
	instance.is_shot = true
	instance.damage += addtl_damage
	
	if instance.damage >= 10:
		instance.scale = Vector3(3,3,3)
