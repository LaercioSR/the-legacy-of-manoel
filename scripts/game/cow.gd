extends Area2D

var is_being_dragged = false
var speed = 100
var color = "painted"
var direction = 1
var paited_probability = 0.7

func _ready():
	color = "painted" if randf() <= paited_probability else "black"
	$TextureRect.texture = load("res://assets/textures/cow-%s.webp" % color)

func _process(delta):
	if not is_being_dragged:
		position.x += direction * speed * delta

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			is_being_dragged = true
		else:
			is_being_dragged = false

func _input(event):
	if is_being_dragged and event is InputEventMouseMotion:
		global_position = event.position
