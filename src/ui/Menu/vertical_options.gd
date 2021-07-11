extends Control

enum SELECTED_MENU_ID {
	CharacterBtn,
	MissionObjBtn,
	FolderBtn,
	OptionsBtn,
	QuitBtn
}

export(Color) var normal_color: Color = Color.dimgray
export(Color) var pressed_color: Color = Color.whitesmoke

onready var Anim: AnimationPlayer = $AnimationPlayer

onready var MenuBtns: Array = $Btns.get_children()
onready var Panels: Array = $Panels.get_children()

onready var CharacterBtn: Button = $Btns/CharacterBtn
onready var MissionObjBtn: Button = $Btns/MissionObjBtn
onready var FolderBtn: Button = $Btns/FolderBtn
onready var OptionsBtn: Button = $Btns/OptionsBtn
onready var QuitBtn: Button = $Btns/QuitBtn

onready var CharacterPanelMaxHealth: Label = $Panels/CharacterPanel/Body/VBoxContainer/Health/VBoxContainer/HBoxContainer/Label2
onready var CharacterPanelProgressBar: TextureProgress = $Panels/CharacterPanel/Body/VBoxContainer/Health/VBoxContainer/HBoxContainer/TextureProgress
onready var CharacterPanelHealth: Label = $Panels/CharacterPanel/Body/VBoxContainer/Health/VBoxContainer/HBoxContainer/Label
onready var CharacterPanelAtkPower: Label = $Panels/CharacterPanel/Body/VBoxContainer/AttackPower/VBoxContainer/CenterContainer/Label
onready var CharacterPanelAtkSpeed: Label = $Panels/CharacterPanel/Body/VBoxContainer/AttackSpeed/VBoxContainer/CenterContainer/Label
onready var CharacterPanelChargeSpeed: Label = $Panels/CharacterPanel/Body/VBoxContainer/ChargeSpeed/VBoxContainer/CenterContainer/Label
onready var CharacterPanelChipReloadSpeed: Label = $Panels/CharacterPanel/Body/VBoxContainer/ChipReloadSpeed/VBoxContainer/CenterContainer/Label


var player: Player


func _ready():
	yield(owner, "ready")
	player = owner.player
	
	yield(player, "ready")
	set_character_panel_max_health()
	set_character_panel_health()
	set_character_panel_atk_power()
	set_character_panel_atk_speed()
	set_character_panel_charge_speed()
	set_character_panel_chip_reload_speed()


func _on_MenuToggleBtn_toggled(button_pressed):
	if button_pressed:
		Anim.play("open")
	else:
		Anim.play("close")
		
	# Clear color for each menu button
	for menu in MenuBtns:
		menu.self_modulate = normal_color
		menu.pressed = false
	
	# Clear visible panels
	for panel in Panels:
		panel.hide()


func _on_CharacterBtn_toggled(button_pressed):
	toggle_selected_menu(SELECTED_MENU_ID.CharacterBtn, button_pressed)
	set_character_panel_max_health()
	set_character_panel_health()


func _on_MissionObjBtn_toggled(button_pressed):
	toggle_selected_menu(SELECTED_MENU_ID.MissionObjBtn, button_pressed)


func _on_FolderBtn_toggled(button_pressed):
	toggle_selected_menu(SELECTED_MENU_ID.FolderBtn, button_pressed)


func _on_OptionsBtn_toggled(button_pressed):
	toggle_selected_menu(SELECTED_MENU_ID.OptionsBtn, button_pressed)


func _on_QuitBtn_pressed():
	toggle_selected_menu(SELECTED_MENU_ID.QuitBtn, true)


func toggle_selected_menu(menu_id: int, button_pressed: bool):
	# Return if invalid id selected
	if menu_id > MenuBtns.size() - 1 or menu_id > Panels.size() - 1:
		return
	
	# Clear color for each menu button
	for menu in MenuBtns:
		menu.self_modulate = normal_color
		menu.pressed = false
	
	# Clear visible panels
	for panel in Panels:
		panel.hide()
	
	# Set color of menu button pressed and show panel
	if button_pressed:
		MenuBtns[menu_id].self_modulate = pressed_color
		Panels[menu_id].show()


func _on_QuitPanel_YES_pressed():
	SceneChanger.goto_scene("res://src/ui/TitleScreen.tscn", get_tree().current_scene)


func _on_QuitPanel_NO_pressed():
	pass # Replace with function body.


func set_character_panel_health():
	CharacterPanelHealth.text = str(player.health)
	CharacterPanelProgressBar.value = player.health


func set_character_panel_max_health():
	CharacterPanelMaxHealth.text = str(player.max_health)
	CharacterPanelProgressBar.max_value = player.max_health


func set_character_panel_atk_power():
	CharacterPanelAtkPower.text = str(player.atk_power)


func set_character_panel_atk_speed():
	CharacterPanelAtkSpeed.text = str(player.atk_speed).pad_decimals(2) + "s"


func set_character_panel_charge_speed():
	CharacterPanelChargeSpeed.text = str(player.charge_speed).pad_decimals(2) + "s"


func set_character_panel_chip_reload_speed():
	CharacterPanelChipReloadSpeed.text = str(player.chip_reload_time).pad_decimals(2) + "s"
