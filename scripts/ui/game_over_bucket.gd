extends CanvasLayer

@export var initialize_minigame = {}

func _on_continue_game_pressed() -> void:
	end_game()

func _on_play_again_pressed() -> void:
	var minigame_scene = load("res://scenes/levels/minigame_bucket.tscn")
	if minigame_scene and minigame_scene.can_instantiate():
		var minigame = minigame_scene.instantiate()
		minigame.initialize(initialize_minigame["game_mode"], initialize_minigame["custom_time"])
		get_parent().add_child(minigame)
	queue_free()


func end_game():
	match initialize_minigame["game_mode"]:
		0:
			get_tree().change_scene_to_file("res://scenes/ui/menus/main.tscn")
			queue_free()
		1:
			get_tree().change_scene_to_file("res://scenes/levels/scene_4.tscn")
			queue_free()
