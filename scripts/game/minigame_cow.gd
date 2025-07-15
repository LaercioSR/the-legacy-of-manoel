extends Node2D
class_name MinigameCow

enum GameMode {MENU, STORY}

@export_category("Objects")
@export var timerLabel: Label
@export var cow_scene: PackedScene
@export var timer: Timer

@export_category("Variables")
@export var spawn_rate = 1.0
@export var spawn_margin = 50
@export var time = 15
@export var game_mode: GameMode = GameMode.MENU

var spawn_timer = 0.0
var screen_size
var game_running = false
var initialized_values = {}

func _ready():
	screen_size = get_viewport_rect().size
	randomize()
	timerLabel.text = str(time) + "s"
	show_tutorial()

func _process(delta):
	if !game_running: return

	spawn_timer += delta
	if spawn_timer >= 1.0 / spawn_rate:
		spawn_cow()
		spawn_timer = 0.0
	cleanup_cows()

func initialize(mode: GameMode, custom_time: int = 15, custom_spawn_rate: float = 1.0):
	initialized_values = {
		"mode": mode,
		"custom_time": custom_time,
		"custom_spawn_rate": custom_spawn_rate
	}
	game_mode = mode
	time = custom_time
	spawn_rate = custom_spawn_rate
	timerLabel.text = str(time) + "s"
	
func show_tutorial():
	var tutorial = preload("res://scenes/ui/tutorials/tutorial_minigame_cow.tscn").instantiate()
	add_child(tutorial)
	tutorial.connect("minigame_tutorial_completed", start_game)

func start_game():
	game_running = true
	timerLabel.text = str(time) + "s"
	timer.start()
	
func restart_game():
	for cow in get_children():
		if cow.is_in_group("cows") or cow.name == "GameOverCow":
			cow.queue_free()
	
	game_running = true
	timer.start()
	spawn_timer = 0.0
	time = initialized_values["custom_time"]
	spawn_rate = initialized_values["custom_spawn_rate"]
	game_mode = initialized_values["mode"]
	timerLabel.text = str(time) + "s"

func cleanup_cows():
	for cow in get_children():
		if cow.is_in_group("cows"):
			if is_out_of_bounds(cow):
				game_over()
				cow.queue_free()

func is_out_of_bounds(cow):
	return (cow.position.y < -spawn_margin or
			cow.position.x < -spawn_margin or
			cow.position.x > screen_size.x + spawn_margin)

func spawn_cow():
	var cow = cow_scene.instantiate()
	add_child(cow)
	cow.z_index = 3
	cow.add_to_group("cows")
	
	var spawn_side = randi() % 2
	cow.direction = 1 if spawn_side == 0 else -1

	var spawn_y = 0
	var spawn_x = 0
	
	spawn_y = randf_range(screen_size.y / 2, screen_size.y - spawn_margin)
	spawn_x = 0 if spawn_side == 0 else screen_size.x - spawn_margin
	
	cow.position = Vector2(spawn_x, spawn_y)
	
	if spawn_side == 1:
		cow.get_node("TextureRect").flip_h = true
	
	if game_mode == GameMode.STORY:
		cow.speed *= 1.3

func game_over():
	if not game_running:
		return
	
	game_running = false
	timer.stop()

	for child in get_children():
		if child.name == "GameOverCow":
			child.queue_free()

	var gameOver = preload("res://scenes/ui/game_over/game_over_cow.tscn").instantiate()
	gameOver.name = "GameOverCow"
	add_child(gameOver)
	gameOver.connect("play_again_pressed", _on_restart_button_pressed)
	gameOver.connect("continue_pressed", end_game)

func end_game():
	match game_mode:
		GameMode.MENU:
			get_tree().change_scene_to_file("res://scenes/ui/menus/main.tscn")
			queue_free()
		
		GameMode.STORY:
			get_tree().change_scene_to_file("res://scenes/levels/scene_6.tscn")
			queue_free()

func _on_timer_timeout() -> void:
	time -= 1
	timerLabel.text = str(time) + "s"
	if time <= 0:
		end_game()

func _on_restart_button_pressed():
	restart_game()
