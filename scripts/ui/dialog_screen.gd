# This code was inspired by the YouTube video:  
# "Como criar um SISTEMA DE DIÁLOGO DO ZERO na GODOT 4.1" by [DevBandeira]  
# Link: https://www.youtube.com/watch?v=1sQ7TwutM0M&t

extends Control
class_name DialogScreen

signal dialog_finished

var step: float = 0.05
var id: int = 0
var data: Dictionary = {}

@export_category("Objects")
@export var nameLabel: Label = null
@export var dialog: RichTextLabel = null
@export var facesetBorder: ColorRect = null
@export var faceset: TextureRect = null

func _ready() -> void:
	initialize_dialog()
	
func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_accept") and dialog.visible_ratio < 1:
		step = 0.01
		return
	
	step = 0.05
	if Input.is_action_just_pressed("ui_accept"):
		id += 1
		if id == data.size():
			emit_signal("dialog_finished")
			queue_free()
			return
			
		initialize_dialog()
	
func initialize_dialog() -> void:
	dialog.text = data[id]["dialog"]
	
	if "title" in data[id]:
		nameLabel.text = data[id]["title"]
		nameLabel.show()
	else:
		nameLabel.hide()
	
	if "faceset" in data[id]:
		faceset.texture = load(data[id]["faceset"])
		facesetBorder.show()
	else:
		facesetBorder.hide()
	
	dialog.visible_characters = 0
	while dialog.visible_ratio < 1:
		await get_tree().create_timer(step).timeout
		dialog.visible_characters += 1
