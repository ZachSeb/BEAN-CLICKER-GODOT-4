extends TextureButton
class_name SideMenuShopButton

@export_enum("Per Click", "Per Second") var button_type: int
@export var base_cost: int

# how much beans a building produces (use for Per Second)
@export var building_production_num: int
# how much beans you make per click (use for Per Click)
@export var production_per_click: int


var owned_buildings: int = 0
var cost: int

func _ready():
	User.connect("beans_stats_changed", update_state)
	
	$".".button_down.connect(try_purchase)
	
	cost = base_cost
	$CostText/Label.text = str(cost)
	
	
func try_purchase() -> void:
	if User.beans >= cost:
		owned_buildings += 1
		User.xp += User.xp_per_building_purchase
		
		User.beans -= cost
		$Sounds/Purchase.play()

		cost = ceili(base_cost * 1.15 * owned_buildings)
		$CostText/Label.text = str(cost)
		
		# flash tween
		var purchase_tween = create_tween()
		purchase_tween.tween_property($Rects/PurchaseRect, "modulate:a", 0, 0.6).from(0.99)
		purchase_tween.play()
		
		# type logic
		if button_type == 0:
			User.beans_per_click = User.evaluate_beans_per_click()
			
		if button_type == 1:
			User.beans_per_second = User.evaluate_beans_per_second()
		
	else:
		$Sounds/Deny.play()
		
		var deny_tween = get_tree().create_tween()
		deny_tween.tween_property($Rects/DenyRect, "modulate:a", 0, 0.6).from(0.99)
		deny_tween.play()
	

func update_state() -> void:
	$Rects/DarkenRect.visible = false if User.beans >= cost else true

