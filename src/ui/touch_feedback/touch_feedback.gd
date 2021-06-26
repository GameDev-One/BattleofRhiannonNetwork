extends CPUParticles2D
"""
# file		touch_feedback.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		22 JUN 2021
# copyright	Copyright (c) 2021 GameDevone
# brief		Provides visual feedback when the player touches the screen.
"""

func _input(event):
	if event is InputEventMouseButton:
		position = event.position
		emitting = true
