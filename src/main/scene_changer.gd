extends Node


func goto_scene(path: String, current_scene: Node) -> void:
	var loader: ResourceInteractiveLoader = ResourceLoader.load_interactive(path)
	
	var loading_bar = load("res://src/ui/LoadingBar.tscn").instance()
	get_tree().get_root().call_deferred('add_child', loading_bar)
	
	
	while true:
		var err = loader.poll()
		if err == ERR_FILE_EOF:
			var resource = loader.get_resource()
			get_tree().get_root().call_deferred('add_child', resource.instance())
			current_scene.queue_free()
			loading_bar.queue_free()
			break
			
		if err == OK:
			var progress: float = float(loader.get_stage()) / loader.get_stage_count()
			loading_bar.value = progress * 100
			
		yield(get_tree(), "idle_frame")
