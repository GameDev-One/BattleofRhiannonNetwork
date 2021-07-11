extends Control

export(NodePath) var player_path: NodePath
onready var player: Player = get_node(player_path)
