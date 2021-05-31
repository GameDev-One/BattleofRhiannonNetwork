extends Control

onready var DebugOut: Label = $VBoxContainer/Label
onready var Btn: Button = $VBoxContainer/Button
onready var debug_font = preload("res://assets/chip/Fonts/battlechip_normal_font.tres")

const MB_CONVERSION_RATE = 1048576

var model_name: String = str("NAME: ") + OS.get_model_name()

var time = OS.get_datetime()
var nameweekday= ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
var namemonth= ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
var dayofweek = time["weekday"]   # from 0 to 6 --> Sunday to Saturday
var day = time["day"]                         #   1-31
var month= time["month"]               #   1-12
var year= time["year"]             
var hour= time["hour"]                     #   0-23
var minute= time["minute"]             #   0-59
var second= time["second"]             #   0-59
var datetime: String = str("DATE: ") + str(day) +  str(namemonth[month-1]) + str(year) + " " + str("%02d" % [hour]) + ":" + str("%02d" % [minute]) + " PST"

var screen_size: String = str("SCREEN SIZE: ") + str(OS.get_screen_size().x) + " x " + str(OS.get_screen_size().y)


func _ready():
	add_property(model_name)
	add_property(datetime)
	add_property(screen_size)
	add_property(get_fps())
	add_property(get_static_memory_usage())
	add_property(get_dyanamic_memory_usage())
	add_property(get_obj_node_count())
	add_property(get_obj_resource_count())
	add_property(get_obj_orphan_node_count())
	add_property(get_render_objects_in_frame())


func _process(delta):
	if Btn.pressed:
		DebugOut.text = ""
		add_property(model_name)
		add_property(datetime)
		add_property(screen_size)
		add_property(get_fps())
		add_property(get_static_memory_usage())
		add_property(get_dyanamic_memory_usage())
		add_property(get_obj_node_count())
		add_property(get_obj_resource_count())
		add_property(get_obj_orphan_node_count())
		add_property(get_render_objects_in_frame())


func add_property(s: String) -> void:
	DebugOut.text += '\n'
	DebugOut.text += s


func get_fps() -> String:
	return str("FPS: ") + str(Performance.get_monitor(Performance.TIME_FPS))


func get_static_memory_usage() -> String:
	return str("STATIC MEMORY USAGE: ") + str(stepify((Performance.get_monitor(Performance.MEMORY_STATIC_MAX) - Performance.get_monitor(Performance.MEMORY_STATIC)) / MB_CONVERSION_RATE, 0.001)) + "MB / " + str(stepify(Performance.get_monitor(Performance.MEMORY_STATIC_MAX) / MB_CONVERSION_RATE, 0.001)) + "MB"


func get_dyanamic_memory_usage() -> String:
	return str("DYNAMIC MEMORY USAGE: ") + str(stepify((Performance.get_monitor(Performance.MEMORY_DYNAMIC_MAX) - Performance.get_monitor(Performance.MEMORY_DYNAMIC)) / MB_CONVERSION_RATE, 0.001)) + "MB / " + str(stepify(Performance.get_monitor(Performance.MEMORY_DYNAMIC_MAX) / MB_CONVERSION_RATE, 0.001)) + "MB"


func get_obj_node_count() -> String:
	return str("ACTIVE NODE COUNT: ") + str(Performance.get_monitor(Performance.OBJECT_NODE_COUNT))


func get_obj_resource_count() -> String:
	return str("ACTIVE RESOURCE COUNT: ") + str(Performance.get_monitor(Performance.OBJECT_RESOURCE_COUNT))


func get_obj_orphan_node_count() -> String:
	return str("ORPHAN NODE COUNT: ") + str(Performance.get_monitor(Performance.OBJECT_ORPHAN_NODE_COUNT))


func get_render_objects_in_frame() -> String:
	return str("OBJECTS IN FRAME: ") + str(Performance.get_monitor(Performance.RENDER_OBJECTS_IN_FRAME))


func _on_Button_toggled(button_pressed):
	if button_pressed:
		DebugOut.show()
	else:
		DebugOut.hide()
