extends Node

func _ready():
	pass


func _on_Button_pressed():
	SceneChanger.goto_scene("res://main.tscn", self)
	ParticleCache.cache()
	pass # Replace with function body.
