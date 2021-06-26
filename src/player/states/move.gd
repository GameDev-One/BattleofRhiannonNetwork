extends PlayerState
# Parent state for all movement-related states for the Player.
# Holds all of the base movement logic.
# Child states can override this state's functions or change its properties.
# This keeps the logic grouped in one location.


export var max_speed: = 12.0
export var move_speed: = 10.0
export var gravity = -80.0
export var jump_impulse = 25
export(float, 0.1, 20.0, 0.1) var rotation_speed_factor: = 10.0

var velocity: = Vector3.ZERO


func unhandled_input(event: InputEvent) -> void:
	pass

func process(delta: float) -> void:
	if player.health <= 0:
		_state_machine.transition_to("Death")
	
	if Input.is_action_pressed("ui_action6"):
		_state_machine.transition_to("Move/Charge")
		
	if Input.is_action_just_pressed("ui_action1"):
		_state_machine.transition_to("Battle", {action_index = 1})
	if Input.is_action_just_pressed("ui_action2"):
		_state_machine.transition_to("Battle", {action_index = 2})
	if Input.is_action_just_pressed("ui_action3"):
		_state_machine.transition_to("Battle", {action_index = 3})
	if Input.is_action_just_pressed("ui_action4"):
		_state_machine.transition_to("Battle", {action_index = 4})
	if Input.is_action_just_pressed("ui_action5"):
		_state_machine.transition_to("Battle", {action_index = 5})
		pass

func physics_process(delta: float) -> void:
	var input_direction = get_joystick_direction()

	# Calculate a move direction vector relative to the camera
	# The basis stores the (right, up, -forwards) vectors of our camera.
	var forwards: Vector3 = player.camera.global_transform.basis.z * input_direction.z
	var right: Vector3 = player.camera.global_transform.basis.x * input_direction.x
	var move_direction: = forwards + right
	if move_direction.length() > 1.0:
		move_direction = move_direction.normalized()
	move_direction.y = 0
	skin.move_direction = move_direction

	# Rotation
	if move_direction:
		var target_direction: = player.transform.looking_at(player.global_transform.origin + move_direction, Vector3.UP)
		player.transform = player.transform.interpolate_with(target_direction, rotation_speed_factor * delta)

	# Movement
	velocity = calculate_velocity(velocity, move_direction, delta)
	velocity = player.move_and_slide(velocity, Vector3.UP)
	
	# Collision
	for i in player.get_slide_count():
		var collision: KinematicCollision = player.get_slide_collision(i)
		if collision.collider.is_in_group("Enemy"):
			_state_machine.transition_to("Collide/Enemy", {collision = collision,
														velocity = velocity
														})
		elif collision.collider.is_in_group("EnemyAttack"):
			_state_machine.transition_to("Collide/EnemyAttack", {collision = collision,
														velocity = velocity
														})


func enter(msg: Dictionary = {}) -> void:
	pass


func exit() -> void:
	pass


static func get_input_direction() -> Vector3:
	return Vector3(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			0,
			Input.get_action_strength("move_back") - Input.get_action_strength("move_front")
		)
		
func get_joystick_direction() -> Vector3:
	return Vector3(
		player.joystick.output.x,
		0,
		player.joystick.output.y
	)


func calculate_velocity(
		velocity_current: Vector3,
		move_direction: Vector3,
		delta: float
	) -> Vector3:
		var velocity_new := move_direction * move_speed
		if velocity_new.length() > max_speed:
			velocity_new = velocity_new.normalized() * max_speed
		velocity_new.y = velocity_current.y + gravity * delta

		return velocity_new
