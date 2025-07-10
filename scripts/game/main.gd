extends Control

@onready var h_box_container: HBoxContainer = $HBoxContainer
@onready var minigames_menu: ColorRect = $minigamesMenu

var MINIGAME_COW = preload("res://scenes/levels/minigame_cow.tscn")

func _ready() -> void:
	minigames_menu.hide()
	h_box_container.show()

func _on_btn_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/scene_1.tscn")

func _on_btn_exit_pressed() -> void:
	get_tree().quit()

func _on_btn_minigames_pressed() -> void:
	h_box_container.hide()
	minigames_menu.show()

func _on_btn_back_initial_pressed() -> void:
	minigames_menu.hide()
	h_box_container.show()

func _on_btn_minigame_cow_pressed() -> void:
	get_tree().change_scene_to_packed(MINIGAME_COW)
