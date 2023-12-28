extends Node

const BigNumberClass = preload("res://addons/BigNumberClass/Big.gd")


func separate_commas(number: int) -> String:
	var string = str(number)
	var mod = string.length() % 3
	var result = ""

	for i in range(0, string.length()):
		if i != 0 && i % 3 == mod:
			result += ","
		result += string[i]
	
	return str(result)
	

func abbreviate_number(number: int) -> String:
	if abs(number) < 1000:
		return separate_commas(number)
	
	const number_abbreviations = ["", "K", "M", "B", "T", "Qa", "Qi", "Sx", "Sp", "Oc"]
	
	var abs_number = abs(number)
	var index = 0

	while abs_number >= 1000 and index < number_abbreviations.size() - 1:
		abs_number = abs_number / 1000.0
		index += 1

	return str(snapped(abs_number, 0.01), number_abbreviations[index])
