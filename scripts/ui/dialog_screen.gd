extends Control
class_name DialogScreen

var step: float = 0.05
var id: int = 0
var data: Dictionary = {}

@export_category("Objects")
@export var nameLabel: Label = null
@export var dialog: RichTextLabel = null
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
			queue_free()
			return
			
		initialize_dialog()
	
func initialize_dialog() -> void:
	nameLabel.text = data[id]["title"]
	dialog.text = data[id]["dialog"]
	faceset.texture = load(data[id]["faceset"])
	
	dialog.visible_characters = 0
	while dialog.visible_ratio < 1:
		await get_tree().create_timer(step).timeout
		dialog.visible_characters += 1
