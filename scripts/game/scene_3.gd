extends Node2D
class_name Scene3

const DIALOG_SCREEN: PackedScene = preload("res://scenes/ui/dialogs/dialog_screen.tscn")
var dialog_data: Dictionary = {
	0: {
		"dialog": "Com o tempo, a seca chegou ao sertão. As lagoas foram se esvaziando, a terra rachando."
	},
	1: {
		"title": "Anastácia",
		"dialog": "Manoel... a água tá sumindo. Preciso buscar mais antes que acabe de vez.",
		"faceset": "res://assets/textures/anastacia_faceset.webp"
	},
	2: {
		"title": "Manoel",
		"dialog": "Vá com calma, minha velha. Cuidado com o caminho.",
		"faceset": "res://assets/textures/manoel_faceset.webp"
	},
}

@export var hud: CanvasLayer = null
@export var waterTexture: TextureRect = null

var time = 1
var current_tween: Tween

func _ready() -> void:
	var new_dialod: DialogScreen = DIALOG_SCREEN.instantiate()
	new_dialod.data = dialog_data
	hud.add_child(new_dialod)
	
	new_dialod.connect("dialog_finished", _on_dialog_finished)
	
func _on_dialog_finished() -> void:
	var minigame = preload("res://scenes/levels/minigame_bucket.tscn").instantiate()
	minigame.initialize(MinigameCow.GameMode.STORY)
	get_parent().add_child(minigame)
	queue_free()

func _on_timer_timeout() -> void:
	time += 1
	
	if time <= 5:
		waterTexture.texture = load("res://assets/textures/scene_3_water_%d.webp" % time)
