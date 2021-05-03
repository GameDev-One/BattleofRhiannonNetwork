extends PlayerState

onready var bullet = preload("res://src/bullet/bullet.tscn")
onready var cooldown_timer: Timer = $Cooldown


func enter(msg := {}) -> void:
	if cooldown_timer.is_stopped():
		var instance = bullet.instance()
		add_child(instance)
		instance.global_transform = player.muzzle.global_transform
		instance.set_as_toplevel(true)
		
		cooldown_timer.start()
		
	_state_machine.transition_to("Move/Idle")
	
func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
