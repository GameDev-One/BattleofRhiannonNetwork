extends ProgressBar

onready var player = $"../.."
onready var label = $Label

func _ready():
	player.connect("health_changed", self, "_on_player_health_changed")


func _on_player_health_changed(health: int) -> void:
	max_value = player.max_health
	value = health
	label.text = str(player.health) + " / " + str(player.max_health)
