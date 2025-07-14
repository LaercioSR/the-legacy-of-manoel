extends Control

func _on_btn_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/scene_1.tscn")

func _on_btn_exit_pressed() -> void:
	get_tree().quit()

func _on_btn_minigames_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/menus/minigames.tscn")


func _on_btn_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/credits/credits.tscn")
