extends Area2D

@export var target_color = "painted"

func _on_area_entered(area: Area2D) -> void:
	if area.color == target_color:
		area.queue_free()
