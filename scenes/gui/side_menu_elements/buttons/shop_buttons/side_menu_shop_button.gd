extends TextureButton
class_name SideMenuShopButton

@export_enum("Per Click", "Per Second") var button_type: int
@export var title_name: String
@export var base_cost: int

# how much beans a building produces (use for Per Second)
@export var building_production_num: int
# how much beans you make per click (use for Per Click)
@export var production_per_click: int


var owned_buildings: int = 0
var cost: int:
	get: return cost
	set(value):
		cost = value
		update_state()


func save_stats() -> Dictionary:
	var save_dict = {
		"filename" : $".".get_path(),
		"parent" : get_parent().get_path(),
		
		"cost" : cost,
		"base_cost" : base_cost,
		"owned_buildings" : owned_buildings,
		
		"building_production_num" : building_production_num,
		"production_per_click" : production_per_click
	}
	return save_dict
	

func _ready():
	update_state()
	User.beans_stats_changed.connect(update_state)
	SaveFile.file_loaded.connect(update_state)
	
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
	$CostText/Label.text = str(cost)
	$Rects/DarkenRect.visible = false if User.beans >= cost else true
	$SideInfo.update_state()


func _on_mouse_entered():
	$SideInfo.visible = true


func _on_mouse_exited():
	$SideInfo.visible = false
	

func _process(_delta):
	var local_mouse_pos_y = $".".get_local_mouse_position().y
	
	$SideInfo.anchor_top = local_mouse_pos_y / size.y
	$SideInfo.anchor_bottom = $SideInfo.anchor_top
