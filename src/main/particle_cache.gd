extends Node

signal loaded

var magnum_anticipation = preload("res://src/player/battle/chip/projectile/magnum/particle_materials/anticipation.tres")
var magnum_anticipation_level_one = preload("res://src/player/battle/chip/projectile/magnum/particle_materials/anticipation_level_one.tres")
var magnum_body = preload("res://src/player/battle/chip/projectile/magnum/particle_materials/body.tres")
var magnum_impact = preload("res://src/player/battle/chip/projectile/magnum/particle_materials/impact.tres")
var magnum_impact_level_two = preload("res://src/player/battle/chip/projectile/magnum/particle_materials/impact_level_two.tres")


var materials: Array = [
	magnum_anticipation,
	magnum_anticipation_level_one,
	magnum_body,
	magnum_impact,
	magnum_impact_level_two
]

var progress: float = 0.0

var _current_material_index: int = 0


func cache():
	var loading_bar = load("res://src/ui/LoadingBar.tscn").instance()
	get_tree().get_root().call_deferred('add_child', loading_bar)
	
	for mat in materials:
		var instance: Particles = Particles.new()
		instance.set_process_material(mat)
		instance.set_one_shot(true)
		instance.set_emitting(true)
		self.add_child(instance)
		
		progress += 1.0 / materials.size()
		loading_bar.value = progress * 100
	
	emit_signal("loaded")
	loading_bar.queue_free()
