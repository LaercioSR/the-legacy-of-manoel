extends Control

func _on_btn_minigame_cow_pressed() -> void:
	var minigame = preload("res://scenes/levels/minigame_cow.tscn").instantiate()
	minigame.initialize(MinigameCow.GameMode.MENU, 30, 0.8)
	get_parent().add_child(minigame)


func _on_btn_minigame_bucket_pressed() -> void:
	var minigame = preload("res://scenes/levels/minigame_bucket.tscn").instantiate()
	minigame.initialize(MinigameCow.GameMode.MENU, 30)
	get_parent().add_child(minigame)


func _on_btn_back_initial_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/menus/main.tscn")
