extends Node

var DebugOut:Control = null


func _ready():
	DebugOut = load("res://src/ui/debug/debug_out.tscn").instance()
	get_tree().get_root().call_deferred('add_child', DebugOut)
	
func add_property(s: String) -> void:
	DebugOut.DebugOut.text += '\n'
	DebugOut.DebugOut.text += s
