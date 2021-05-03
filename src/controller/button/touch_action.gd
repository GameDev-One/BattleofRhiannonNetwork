extends TouchScreenButton

export var pressed_color: Color = Color.gray

onready var _original_color : Color = self.modulate

func _on_TouchAction_pressed():
	modulate = pressed_color


func _on_TouchAction_released():
	modulate = _original_color

