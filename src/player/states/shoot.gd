extends PlayerState

onready var bead = preload("res://src/bead/Bead.tscn")
onready var cooldown_timer: Timer = $Cooldown


func enter(msg := {}) -> void:
	if cooldown_timer.is_stopped():
		_spawn_bullet()
		
	_state_machine.transition_to("Move/Idle")
	
func _spawn_bullet() -> void:
	var instance = bead.instance()
	add_child(instance)
	instance.global_transform = player.muzzle.global_transform
	instance.is_shot = true
	cooldown_timer.start()
