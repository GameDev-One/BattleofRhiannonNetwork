extends PlayerState

export var max_charge_time: float = 5.0

var _charge_time: float = 0.0


func process(delta):
	_charge_time += delta
	clamp(_charge_time + delta, 0.0, max_charge_time)
	
	var percent_charged = _charge_time / max_charge_time
	
	if Input.is_action_just_released("ui_action6"):
		_charge_time = 0.0
		_state_machine.transition_to("Shoot", {percent_charged = percent_charged})
