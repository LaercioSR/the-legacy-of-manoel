extends ScrollContainer

@export var textNode: Control
@export_range(1,10000,0.1) var credits_time: float = 1
@export_range(0,10000,0.1) var margin_increment: float = 0

@onready var margin: MarginContainer = $Margin

func _ready() -> void:
	var tween = create_tween()
	
	var text_box_size = textNode.size.y
	
	var window_size = DisplayServer.window_get_size().y
	margin.add_theme_constant_override("margin_top", window_size + margin_increment)

	var scroll_amount : int = ceil(text_box_size * 3/4 + window_size + margin_increment)
	
	tween.tween_property(
		self,
		"scroll_vertical",
		scroll_amount,
		credits_time
	)
	tween.finished.connect(_credits_completed)
	tween.play()

func _credits_completed() -> void:
	await get_tree().create_timer(2.5).timeout
	get_tree().change_scene_to_file("res://scenes/ui/menus/main.tscn")
