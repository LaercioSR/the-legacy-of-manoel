extends Node2D

@export var cow_scene: PackedScene
@export var spawn_rate = 1.0
@export var spawn_margin = 50

var spawn_timer = 0.0
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	randomize()

func _process(delta):
	spawn_timer += delta
	if spawn_timer >= 1.0 / spawn_rate:
		spawn_cow()
		spawn_timer = 0.0

func spawn_cow():
	var cow = cow_scene.instantiate()
	add_child(cow)
	
	var spawn_side = randi() % 2

	if spawn_side == 0:
		cow.direction = 1
	else:
		cow.direction = -1 

	var spawn_y = randf_range(screen_size.y / 2, screen_size.y - spawn_margin)

	var spawn_x = 0
	if spawn_side == 0:
		spawn_x = 0
	else:
		spawn_x = screen_size.x - spawn_margin

	cow.position = Vector2(spawn_x, spawn_y)
	
	if spawn_side == 1:
		cow.get_node("TextureRect").flip_h = true
