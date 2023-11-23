extends SettingsDropDown

func refresh(_reset):
	$OptionButton.selected = Settings.display_mode


func on_item_selected(index: int):
	Settings.display_mode = index
