extends Control

@onready var shop_button = $".."


func update_state():
	$NameLabel.text = shop_button.title_name
	
	var copies = "copy" if shop_button.owned_buildings == 1 else "copies"
	var plural_click = "bean" if shop_button.owned_buildings * shop_button.production_per_click == 1 else "beans"
	var plural_sec = "bean" if shop_button.owned_buildings * shop_button.building_production_num == 1 else "beans"
	
	if shop_button.button_type == 0:
		$VBoxContainer/PerInfo.text = str(
			shop_button.owned_buildings, " ",
			copies,
			" making ",
			shop_button.owned_buildings * shop_button.production_per_click, " ",
			plural_click,
			" per click")
			
		$VBoxContainer/TotalInfo.text = str(
			"Each producing ",
			shop_button.production_per_click,
			" per click"
			)
	
	else:
		$VBoxContainer/PerInfo.text = str(
			shop_button.owned_buildings, " ",
			copies,
			" making ",
			shop_button.owned_buildings * shop_button.building_production_num, " ",
			plural_sec,
			" per second")
			
		$VBoxContainer/TotalInfo.text = str(
			"Each producing ",
			shop_button.building_production_num,
			" per second"
			)
