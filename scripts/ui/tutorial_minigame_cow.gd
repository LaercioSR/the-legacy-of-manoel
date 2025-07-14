extends CanvasLayer

signal minigame_tutorial_completed

@export var startButton: TextureButton

func _ready():
	startButton.grab_focus()

func _on_start_button_pressed():
	emit_signal("minigame_tutorial_completed")
	queue_free()
	return
