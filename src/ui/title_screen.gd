extends Node

func _ready():
	ParticleCache.cache()
	SceneChanger.goto_scene("res://main.tscn", self)
