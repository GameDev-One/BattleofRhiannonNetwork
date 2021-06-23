extends PlayerState
"""
# file		enemy_attack.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		22 JUN 2021
# copyright	Copyright (c) 2021 GameDevone
# brief		Contains logic for when a player has a collision with an EnemyAttack
			object. i.e an EnemyAttack(RigidBody).
# note		This can be accessed when creating a new script and clicking the 
			templates option.
"""


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
	player.health -= msg["collision"].collider.owner.attack_damage
	player.damage_ind.value = msg["collision"].collider.owner.attack_damage
	
	var direction = player.global_transform.origin - msg["collision"].collider.owner.global_transform.origin
	
	_parent.enter( {collision = msg["collision"], velocity = direction})


"""
# brief		Called as the object is transitioned out of this state.
"""
func exit() -> void:
	_parent.exit()
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
	_parent.physics_process(delta)
	pass


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
