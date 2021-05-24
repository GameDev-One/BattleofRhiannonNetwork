extends PlayerState


onready var bead = preload("res://src/bead/Bead.tscn")
onready var cooldown_timer: Timer = $Cooldown


func enter(msg := {}) -> void:
	if cooldown_timer.is_stopped():
		if msg.percent_charged > .98:
			_spawn_bullet(9)
		elif msg.percent_charged > .3:
			_spawn_bullet(2)
		else:
			_spawn_bullet()
		
	_state_machine.transition_to("Move/Run")
	
func _spawn_bullet(addtl_damage: int = 0) -> void:
	var instance = bead.instance()
	add_child(instance)
	instance.global_transform = player.muzzle.global_transform
	instance.is_shot = true
	instance.damage += addtl_damage
	
	if instance.damage >= 10:
		instance.scale = Vector3(3,3,3)
	
	cooldown_timer.start()
