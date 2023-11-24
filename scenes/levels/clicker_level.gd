extends Node2D


func _ready():
	SaveFile.load_file()
	print(User.beans)
