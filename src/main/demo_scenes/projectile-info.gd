extends Control

onready var Title: Label = $Label

func update_text(s: String) -> void:
	Title.text = s
