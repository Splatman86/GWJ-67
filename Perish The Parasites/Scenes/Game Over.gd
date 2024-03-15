extends Node2D

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Prototype.tscn")
	Global.LegParasites = 0
	Global.TorsoParasites = 0
	Global.HeadParasites = 0
