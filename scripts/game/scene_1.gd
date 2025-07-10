extends Node2D
class_name Scene1

const DIALOG_SCREEN: PackedScene = preload("res://scenes/ui/dialogs/dialog_screen.tscn")
var dialog_data: Dictionary = {
	0: {
		"dialog": "Por volta de 1830, o casal Manoel Gonçalves e Dona Anastácia partiu em busca de uma vida melhor. Eles deixaram uma fazenda onde trabalhavam na Vila de Sant’Anna de Feira (atual Feira de Santana) na esperança de encontrar um novo lar."
	}
}

@export var hud: CanvasLayer = null

func _ready() -> void:
	var new_dialod: DialogScreen = DIALOG_SCREEN.instantiate()
	new_dialod.data = dialog_data
	hud.add_child(new_dialod)
	
	new_dialod.connect("dialog_finished", _on_dialog_finished)
	
func _on_dialog_finished() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/scene_2.tscn")
