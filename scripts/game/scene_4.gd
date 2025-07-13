extends Node2D
class_name Scene4

const DIALOG_SCREEN: PackedScene = preload("res://scenes/ui/dialogs/dialog_screen.tscn")
var dialog_data: Dictionary = {
	0: {
		"dialog": "Com a seca contínua o casal Gonçalves busca novas possibilidades."
	},
	1: {
		"title": "Manoel",
		"dialog": "Oh minha velha, vamos ter que nos mudar para mais perto da lagoa.",
		"faceset": "res://assets/textures/manoel_faceset.webp"
	},
	2: {
		"title": "Anastácia",
		"dialog": "Acho uma boa, meu velho!",
		"faceset": "res://assets/textures/anastacia_faceset.webp"
	},
}

@export var hud: CanvasLayer = null

func _ready() -> void:
	var new_dialod: DialogScreen = DIALOG_SCREEN.instantiate()
	new_dialod.data = dialog_data
	hud.add_child(new_dialod)
	
	new_dialod.connect("dialog_finished", _on_dialog_finished)
	
func _on_dialog_finished() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/scene_5.tscn")
