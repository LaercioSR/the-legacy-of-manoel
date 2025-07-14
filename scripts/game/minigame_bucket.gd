extends Node2D

enum GameMode {MENU, STORY}

@export_category("Objects")
@export var timerLabel: Label
@export var balancingObject: RigidBody2D
@export var timer: Timer
@export var biasChangeTimer: Timer

@export_category("Variables")
@export var balance_speed = 1000
@export var max_tilt = 25
@export var initial_tilt_force = 25000
@export var gravity_effect = 10
@export var difficulty_increase_rate = 0.1
@export var constant_bias = 2.0
@export var time = 15
@export var game_mode: GameMode = GameMode.MENU

var game_running = false
var current_bias_direction = 1

func _ready():
	balancingObject.angular_damp = 1.2
	balancingObject.gravity_scale = 0
	
	current_bias_direction = 1 if randf() > 0.5 else -1
	
	balancingObject.apply_torque(current_bias_direction * initial_tilt_force)
	show_tutorial()
	
	
func initialize(mode: GameMode, custom_time: int = 15):
	game_mode = mode
	time = custom_time
	timerLabel.text = str(time) + "s"

func show_tutorial():
	var tutorial = preload("res://scenes/ui/tutorials/tutorial_minigame_bucket.tscn").instantiate()
	add_child(tutorial)
	tutorial.connect("minigame_tutorial_completed", start_game)

func start_game():
	game_running = true
	timerLabel.text = str(time) + "s"
	timer.start()
	biasChangeTimer.start()

func _physics_process(delta):
	if not game_running:
		return
	
	gravity_effect += difficulty_increase_rate * delta
	
	var tilt_gravity = sin(balancingObject.rotation) * gravity_effect * 150
	
	var constant_bias_force = current_bias_direction * constant_bias
	
	var random_force = randf_range(-1.5, 1.5)
	
	balancingObject.apply_torque(tilt_gravity + constant_bias_force + random_force)
	
	var input = Input.get_axis("ui_left", "ui_right")
	if input != 0:
		balancingObject.apply_torque(input * balance_speed)
	
	balancingObject.rotation = clamp(
		balancingObject.rotation, 
		deg_to_rad(-max_tilt), 
		deg_to_rad(max_tilt)
	)
	
	if abs(rad_to_deg(balancingObject.rotation)) > max_tilt * 0.95:
		game_over()

func _on_bias_change_timer_timeout():
	current_bias_direction *= -1
	biasChangeTimer.wait_time = randf_range(2.0, 5.0)
	biasChangeTimer.start()

func game_over():
	game_running = false

func _on_restart_button_pressed():
	get_tree().reload_current_scene()


func _on_timer_timeout() -> void:
	time -= 1
	timerLabel.text = str(time) + "s"
	if time <= 0:
		end_game()

func end_game():
	match game_mode:
		GameMode.MENU:
			get_tree().change_scene_to_file("res://scenes/ui/menus/main.tscn")
			queue_free()
		
		GameMode.STORY:
			get_tree().change_scene_to_file("res://scenes/levels/scene_4.tscn")
			queue_free()
