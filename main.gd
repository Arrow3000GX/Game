extends Node2D


func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_play_pressed() -> void:
	Globals.gamemode = 0
	get_tree().change_scene_to_file("res://world.tscn")

func _on_hard_pressed() -> void:
	if Globals.hard_unlocked:
		Globals.gamemode = 1
		get_tree().change_scene_to_file("res://world_hard.tscn")
