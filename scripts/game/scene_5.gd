extends Node2D
class_name Scene5

const DIALOG_SCREEN: PackedScene = preload("res://scenes/ui/dialogs/dialog_screen.tscn")
var dialog_data: Dictionary = {
	0: {
		"dialog": "Assim o casal se mudou para perto da Lagoa do Bamburrá, onde construiram sua segunda casa."
	}
}

@export var hud: CanvasLayer = null

func _ready() -> void:
	var new_dialod: DialogScreen = DIALOG_SCREEN.instantiate()
	new_dialod.data = dialog_data
	hud.add_child(new_dialod)
	
	new_dialod.connect("dialog_finished", _on_dialog_finished)
	
func _on_dialog_finished() -> void:
	var minigame = preload("res://scenes/levels/minigame_cow.tscn").instantiate()
	minigame.initialize(MinigameCow.GameMode.STORY, 15, 1)
	get_parent().add_child(minigame)
	queue_free()
