extends Control

signal change_state(state: int)

@export var state: int = 1
@export var tab_group: ButtonGroup

func _ready():
	for tab in tab_group.get_buttons():
		tab.pressed.connect(on_press)
		
	update_fertilizer_count()
	User.connect("fertilizer_changed", update_fertilizer_count)
		
		
func on_press() -> void:
	var tab = tab_group.get_pressed_button()
	
	print(tab.name)
	change_state.emit(tab.name)
	
	$State/Label.text = tab.name
	$TabSwitchSound.play()
	
	if tab.name == "Upgrades":
		$State/FertilizerCount.visible = true
	else:
		$State/FertilizerCount.visible = false
		

func update_fertilizer_count() -> void:
	$State/FertilizerCount/Label.text = str(User.fertilizer)
	
	
func _process(_delta):
	for tab in tab_group.get_buttons():
		if tab.button_pressed:
			tab.get_node("Icon").anchor_bottom = 0.94
			tab.get_node("Icon").anchor_top = 0.19
		else:
			tab.get_node("Icon").anchor_bottom = 0.95
			tab.get_node("Icon").anchor_top = 0.35
