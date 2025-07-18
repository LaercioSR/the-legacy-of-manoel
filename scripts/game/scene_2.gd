extends Node2D
class_name Scene2

const DIALOG_SCREEN: PackedScene = preload("res://scenes/ui/dialogs/dialog_screen.tscn")
var dialog_data: Dictionary = {
	0: {
		"dialog": "Após muita andança, o casal encontrou uma terra cercada por pedras que guardavam pequenas lagoas. Ali, ergueram a sua primeira casa que daria origem à fazenda hoje conhecida como Lagoa das Pedras."
	}
}

@export var hud: CanvasLayer = null

func _ready() -> void:
	var new_dialod: DialogScreen = DIALOG_SCREEN.instantiate()
	new_dialod.data = dialog_data
	hud.add_child(new_dialod)
	
	new_dialod.connect("dialog_finished", _on_dialog_finished)
	
func _on_dialog_finished() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/scene_3.tscn")
