extends Node

signal beans_stats_changed
signal xp_changed
signal fertilizer_changed


@export_category("Bean Variables")
@export var beans_per_click: int = 1
@export var beans: int = 0:
	get: return beans
	set(value):
		beans = value
		beans_stats_changed.emit()
	
@export var beans_per_second: int = 0:
	get: return beans_per_second
	set(value):
		beans_per_second = value
		beans_stats_changed.emit()


@export var xp_multiplier: float = 1.095
@export var xp_requirement: float = 100

@export var xp_per_click: float = 0.2
@export var xp_per_building_purchase: float = 5

@export var xp: float = 0:
	get: return xp
	set(value):
		xp = value
		xp_changed.emit()
		
@export var fertilizer: int = 0:
	get: return fertilizer
	set(value):
		fertilizer = value
		fertilizer_changed.emit()


#
#func set_data(loaded_data: Dictionary):
#	beans = loaded_data.BEANS
#	beans_per_click = loaded_data.BEANS_PER_CLICK
#	beans_per_second = loaded_data.BEANS_PER_SECOND
#
#	xp = loaded_data.XP
#	xp_requirement = loaded_data.XP_REQUIREMENT
#	xp_per_click = loaded_data.XP_PER_CLICK
#	xp_per_building_purchase = loaded_data.XP_PER_BUILDING_PURCHASE
#
#	fertilizer = loaded_data.FERTILIZER


func save_stats():
	var save_dict = {
		"filename" : $".".get_path(),
		"parent" : get_parent().get_path(),
		
		"beans" : beans,
		"beans_per_click" : beans_per_click,
		"beans_per_second" : beans_per_second,
		
		"xp" : xp,
		"xp_requirement" : xp_requirement,
		"xp_per_click" : xp_per_click,
		"xp_per_building_purchase" : xp_per_building_purchase,
		
		"fertilizer" : fertilizer
	}
	return save_dict


func evaluate_beans_per_second() -> int:
	var return_value = 0
	var side_menu_shop_buttons = get_tree().get_nodes_in_group("SideMenuShopButton")
	
	for button in side_menu_shop_buttons:
		if str(button.button_type) == "1": # PER CLICK
			return_value += button.building_production_num * button.owned_buildings
			
	return int(return_value)


func evaluate_beans_per_click() -> int:
	print('hi')
	var return_value = 0
	var side_menu_shop_buttons = get_tree().get_nodes_in_group("SideMenuShopButton")
	
	for button in side_menu_shop_buttons:
		if str(button.button_type) == "0": # PER CLICK
			return_value += (button.production_per_click * button.owned_buildings)
	
	return_value += 1
	if return_value <= 0:
		return 1
		
	return int(return_value)


func _on_per_second_tick_timeout():
	beans += beans_per_second
