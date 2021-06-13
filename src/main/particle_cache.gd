extends Node

signal loaded

var magnum_anticipation = preload("res://src/player/battle/chip/projectile/magnum/particle_materials/Anticipation.tscn")
var magnum_body = preload("res://src/player/battle/chip/projectile/magnum/particle_materials/Body.tscn")
var magnum_impact = preload("res://src/player/battle/chip/projectile/magnum/particle_materials/Impact.tscn")

var soapie_anticipation = preload("res://src/player/battle/chip/projectile/soapie/particle_materials/Anticipation.tscn")
var soapie_body = preload("res://src/player/battle/chip/projectile/soapie/particle_materials/Body.tscn")
var soapie_impact = preload("res://src/player/battle/chip/projectile/soapie/particle_materials/Impact.tscn")

var succulent_burst_anticipation = preload("res://src/player/battle/chip/projectile/succulent_burst/particle_materials/Anticipation.tscn")
var succulent_burst_body = preload("res://src/player/battle/chip/projectile/succulent_burst/particle_materials/Body.tscn")
var succulent_burst_impact = preload("res://src/player/battle/chip/projectile/succulent_burst/particle_materials/Impact.tscn")

var electron_anticipation = preload("res://src/player/battle/chip/projectile/electron/vfx/Anticipation.tscn")
var electron_body = preload("res://src/player/battle/chip/projectile/electron/vfx/Body.tscn")
var electron_impact = preload("res://src/player/battle/chip/projectile/electron/vfx/Impact.tscn")


var particles: Array = [
	magnum_anticipation,
	magnum_body,
	magnum_impact,
	soapie_anticipation,
	soapie_body,
	soapie_impact,
	succulent_burst_anticipation,
	succulent_burst_body,
	succulent_burst_impact,
	electron_anticipation,
	electron_body,
	electron_impact,
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
