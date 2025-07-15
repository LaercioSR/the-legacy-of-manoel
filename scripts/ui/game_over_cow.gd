extends CanvasLayer

signal play_again_pressed
signal continue_pressed

func _on_continue_game_pressed() -> void:
	emit_signal("continue_pressed")
	queue_free()


func _on_play_again_pressed() -> void:
	emit_signal("play_again_pressed")
	queue_free()
