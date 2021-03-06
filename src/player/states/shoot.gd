extends PlayerState


onready var bead = preload("res://src/bead/Bead.tscn")
onready var cooldown_timer: Timer = $Cooldown


func enter(msg := {}) -> void:
	skin.transition_to(skin.States.SHOOT)
	#print("Playing... " + skin.current_animation_name() + " animation.")
	yield(get_tree().create_timer(0.2), "timeout")
	if cooldown_timer.is_stopped():
		
		if msg.percent_charged > .98:
			_spawn_bullet(9)
		elif msg.percent_charged > .3:
			_spawn_bullet(2)
		else:
			_spawn_bullet()
			
	yield(get_tree().create_timer(0.3), "timeout")
	
	_state_machine.transition_to("Move/Idle")
	
func _spawn_bullet(addtl_damage: int = 0) -> void:
	var instance = bead.instance()
	add_child(instance)
	instance.global_transform = player.muzzle.global_transform
	instance.is_shot = true
	instance.damage += addtl_damage
	
	if instance.damage >= 10:
		instance.scale = Vector3(3,3,3)
	
	cooldown_timer.start()
