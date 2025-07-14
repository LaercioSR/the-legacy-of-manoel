extends Node2D
class_name Scene6

@export var hud: CanvasLayer = null

var titleLabel: Label = null
var bgTexture: TextureRect = null

const DIALOG_SCREEN: PackedScene = preload("res://scenes/ui/dialogs/dialog_screen.tscn")
var dialog_data: Dictionary = {
	0: {
		"dialog": "Manoel deixava as vacas pintadas soltas perto da sua casa, assim as pessoas começaram a chamar aquele lugar de Fazenda Pintadas."
	},
	1: {
		"dialog": "Com o tempo novos moradores chegaram e a fazenda passou a ser Vila, Povoado, Distrito, até que em 09 de maio de 1985 Pintadas finalmente se tornou cidade."
	}
}
var phases = [
	{
		"bg": "res://assets/textures/scene_6_1.webp",
		"title": "fazenda"
	},
	{
		"bg": "res://assets/textures/scene_6_2.webp",
		"title": "vila"
	},
	{
		"bg": "res://assets/textures/scene_6_3.webp",
		"title": "povoado"
	},
	{
		"bg": "res://assets/textures/scene_6_4.webp",
		"title": "distrito"
	},
	{
		"bg": "res://assets/textures/scene_6_5.webp",
		"title": "cidade"
	},
]
var time = 0

func _ready() -> void:
	var new_dialod: DialogScreen = DIALOG_SCREEN.instantiate()
	new_dialod.data = dialog_data
	hud.add_child(new_dialod)
	
	new_dialod.connect("dialog_finished", _on_dialog_finished)
	
	titleLabel = hud.get_node("Title")
	bgTexture = hud.get_node("TextureRect")

func _on_dialog_finished() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/credits/credits.tscn")

func _on_timer_timeout() -> void:
	time += 1

	if time < 5:
		titleLabel.text = "%s PINTADAS" % phases[time]["title"].to_upper()
		bgTexture.texture = load(phases[time]["bg"])
