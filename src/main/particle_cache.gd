extends Node

signal loaded

var magnum_anticipation = preload("res://src/player/battle/chip/projectile/magnum/particle_materials/Anticipation.tscn")
var magnum_anticipation_level_one = preload("res://src/player/battle/chip/projectile/magnum/particle_materials/AnticipationLevelOne.tscn")
var magnum_body = preload("res://src/player/battle/chip/projectile/magnum/particle_materials/Body.tscn")
var magnum_impact = preload("res://src/player/battle/chip/projectile/magnum/particle_materials/Impact.tscn")
var magnum_impact_level_one = preload("res://src/player/battle/chip/projectile/magnum/particle_materials/ImpactLevelOne.tscn")
var magnum_impact_level_two = preload("res://src/player/battle/chip/projectile/magnum/particle_materials/ImpactLevelTwo.tscn")

var particles: Array = [
	magnum_anticipation,
	magnum_anticipation_level_one,
	magnum_body,
	magnum_impact,
	magnum_impact_level_one,
	magnum_impact_level_two,
]

var progress: float = 0.0


func cache():
	var loading_bar = load("res://src/ui/LoadingBar.tscn").instance()
	get_tree().get_root().call_deferred('add_child', loading_bar)
	
	for p in particles:
		var instance: CPUParticles = p.instance()
		self.add_child(instance)
		instance.one_shot = true
		instance.emitting = true
		
		progress += 1.0 / particles.size()
		loading_bar.value = progress * 100
		
	emit_signal("loaded")
	loading_bar.queue_free()
