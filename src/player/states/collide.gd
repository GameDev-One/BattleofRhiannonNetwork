extends PlayerState
"""
# file		collide.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		21 JUN 2021
# copyright	Copyright (c) 2021 GameDevone
# brief		Contains logic for when a player has a collision with a non-static 
			object. i.e an Enemy(KinematicBody) or EnemyAttack(RigidBody)
"""

export(float, 0, 100) var speed: float = 10
onready var InvulnerabilityTimer: Timer = $Invulnerability

var _reflect_velocity: Vector3 = Vector3.ZERO
var _gravity: float = -4.9

"""
# brief		Called when the node is 'ready', i.e. when both the node and its 
			children have entered the scene tree.
"""
func _ready() -> void:
	pass


"""
# brief		Called when object is transitioned to this state.
# param msg	Additional varibales passed along to the requested state.
"""
func enter(msg := {}) -> void:
#	_reflect_velocity = msg["velocity"].reflect(msg["collision"].normal).normalized()
	_reflect_velocity = msg["velocity"].normalized() * speed
	_reflect_velocity.y = _gravity
	InvulnerabilityTimer.start()
	player.is_invulnerable = true
	pass


"""
# brief		Called as the object is transitioned out of this state.
"""
func exit() -> void:
	
	pass


"""
# brief			Called during the physics processing step of the main loop. 
				Physics processing means that the frame rate is synced to the 
				physics, i.e. the delta variable should be constant.
# param delta
				Amount of time that has passed since last call to 
				_physics_process.
"""
func physics_process(delta: float) -> void:
	player.move_and_collide(_reflect_velocity * delta)
			


"""
# brief			Called during the processing step of the main loop. Processing 
				happens at every frame and as fast as possible, so the delta 
				time since the previous frame is not constant.
# param delta
				Amount of time that has passed since last call to _process.
"""
func process(delta: float) -> void:
	pass


"""
# brief			Called when an InputEvent hasn't been consumed by _input() or 
				any GUI.
# param event
				Input event that occured.
"""
func unhandled_input(event: InputEvent) -> void:
	pass


func _on_Invulnerability_timeout():
	player.is_invulnerable = false
	_state_machine.transition_to("Move/Idle")
	pass # Replace with function body.
