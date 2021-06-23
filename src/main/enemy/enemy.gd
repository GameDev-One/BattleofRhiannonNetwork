class_name Enemy
extends KinematicBody


signal health_changed()

# Combat
export(String) var _c_combat
export(int, 1, 9999) var max_health: int = 1
export(int, 1, 9999) var contact_damage: int = 10
export(int, 1, 9999) var attack_damage: int = 10

# Movement
export(String) var _c_movement
export (float, 0, 100, 5) var linear_speed_max := 10.0 setget set_linear_speed_max
export (float, 0, 100, 0.1) var linear_acceleration_max := 1.0 setget set_linear_acceleration_max
export (float, 0, 50, 0.1) var arrival_tolerance := 0.5 setget set_arrival_tolerance
export (float, 0, 50, 0.1) var deceleration_radius := 5.0 setget set_deceleration_radius
export (int, 0, 1080, 10) var angular_speed_max := 270 setget set_angular_speed_max
export (int, 0, 2048, 10) var angular_accel_max := 45 setget set_angular_accel_max
export (int, 0, 178, 2) var align_tolerance := 5 setget set_align_tolerance
export (int, 0, 180, 2) var angular_deceleration_radius := 45 setget set_angular_deceleration_radius

# Global
export(String) var _c_global
export(NodePath) var player_path
export(NodePath) var navigation_path

# Local
export(String) var _c_local
export(NodePath) var body_collision_path
export(NodePath) var dmg_ind_particles_path
export(NodePath) var state_display_path

onready var arriver = self
onready var player: Player = get_node(player_path)
onready var navigation: Navigation = get_node(navigation_path)

onready var body_collison: Area = get_node(body_collision_path)
onready var dmg_ind_particles: CPUParticles = get_node(dmg_ind_particles_path)
onready var state_display: CPUParticles = get_node(state_display_path)

var health: int = max_health setget set_health


func _ready():
	health = max_health
	
	if not body_collison.is_in_group("Enemy"):
		body_collison.add_to_group("Enemy")


func _process(delta):
	if health <= 0:
		queue_free()


func set_health(value: int):
	health = value
	emit_signal("health_changed")
	
	
func set_align_tolerance(value: int) -> void:
	align_tolerance = value
	if not is_inside_tree():
		return
	arriver.face.alignment_tolerance = deg2rad(value)


func set_angular_deceleration_radius(value: int) -> void:
	deceleration_radius = value
	if not is_inside_tree():
		return
	arriver.face.deceleration_radius = deg2rad(value)


func set_angular_accel_max(value: int) -> void:
	angular_accel_max = value
	if not is_inside_tree():
		return
	arriver.agent.angular_acceleration_max = deg2rad(value)


func set_angular_speed_max(value: int) -> void:
	angular_speed_max = value
	if not is_inside_tree():
		return
	arriver.agent.angular_speed_max = deg2rad(value)


func set_arrival_tolerance(value: float) -> void:
	arrival_tolerance = value
	if not is_inside_tree():
		return
	arriver.arrive.arrival_tolerance = value


func set_deceleration_radius(value: float) -> void:
	deceleration_radius = value
	if not is_inside_tree():
		return
	arriver.arrive.deceleration_radius = value


func set_linear_speed_max(value: float) -> void:
	linear_speed_max = value
	if not is_inside_tree():
		return
	arriver.agent.linear_speed_max = value


func set_linear_acceleration_max(value: float) -> void:
	linear_acceleration_max = value
	if not is_inside_tree():
		return
	arriver.agent.linear_acceleration_max = value


func _on_body_entered(body: Node):
	if body.is_in_group("Player"):
		body.health -= contact_damage
		body.damage_ind.value = contact_damage
