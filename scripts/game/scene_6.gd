extends Node2D
class_name Scene6

const DIALOG_SCREEN: PackedScene = preload("res://scenes/ui/dialogs/dialog_screen.tscn")
var dialog_data: Dictionary = {
	0: {
		"dialog": "Manoel deixava as vacas pintadas soltas perto da sua casa, assim as pessoas começaram a chamar aquele lugar de Fazenda Pintadas."
	},
	1: {
		"dialog": "Com o tempo novos moradores chegaram e a fazenda passou a ser Vila, Povoado, Distrito, até que em 09 de maio de 1985 Pintadas finalmente se tornou cidade."
	}
}

@export var hud: CanvasLayer = null

func _ready() -> void:
	var new_dialod: DialogScreen = DIALOG_SCREEN.instantiate()
	new_dialod.data = dialog_data
	hud.add_child(new_dialod)
	
	new_dialod.connect("dialog_finished", _on_dialog_finished)

func _on_dialog_finished() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/menus/main.tscn")
