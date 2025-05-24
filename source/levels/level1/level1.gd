class_name level1
extends Node2D

enum game_states {
	INITIAL,
	RUNNING,
	PAUSED,
	OVER
}

const INITIAL_GOLD: int = 200

var current_wave: int = 0
var game_state: int = game_states.INITIAL
var wave_manager: WaveManager = WaveManager.new()


@onready var enemy_path: Path2D = $EnemyPath
@onready var upgrade_window: Control = $UpgradeWindow
@onready var drop_control: DropControl = $DropControl
@onready var side_menu: SideMenu = $SideMenu
@onready var bgm: AudioStreamPlayer = $BGM
@onready var pause_screen: Panel = $PauseScreen
@onready var game_over: GameOver = $GameOver
@onready var castle: Castle = $Castle



func _ready() -> void:
	# update location of starting buildings
	drop_control.get_occupied_areas()
	
	# connect signals
	Economy.gold_changed.connect(on_gold_changed)
	drop_control.building_placed.connect(on_building_placed)
	upgrade_window.visibility_changed.connect(on_upgrade_window_visibility_changed)
	side_menu.pause_requested.connect(on_pause_requested)
	side_menu.play_requested.connect(start_wave)
	castle.castle_destroyed.connect(on_castle_destroyed)
	game_over.new_game_requested.connect(on_new_game_requested)
	game_over.end_game_requested.connect(on_quit_game_requested)
	
	# initialize level
	initialize()
	
	# update GUI
	upgrade_window.visible = false
	
	# add wave manager
	add_child(wave_manager)
	
	# play music
	#bgm.play()
	#side_menu.mute_button.button_pressed = true
	
	

func initialize() -> void:
	Economy.current_gold = INITIAL_GOLD
	wave_manager.initialize(enemy_path)
	side_menu.pause_button.disabled = true
	game_state = game_states.INITIAL
	on_gold_changed()

func clear_board() -> void:
	# reset castle
	castle.reset_health()
	castle.show_sprite()
	
	# eliminate remaining enemies
	for child in enemy_path.get_children():
		child.queue_free()
		
	# remove any towers
	for child in drop_control.get_children():
		if child is not Area2D:
			child.free()
	#await get_tree().get_frame()
	#drop_control.call_deferred("get_occupied_areas")
	drop_control.get_occupied_areas()

func start_wave() -> void:
	side_menu.pause_button.disabled = false
	if game_state == game_states.INITIAL:
		game_state = game_states.RUNNING
		wave_manager.spawn_cd.start()

func on_gold_changed() -> void:
	side_menu.set_gold_label(Economy.current_gold)

func on_building_placed(building: Tower) -> void:
	building.upgrade_requested.connect(on_building_upgrade_requested)
	
func on_building_upgrade_requested(building: Tower) -> void:
	upgrade_window.update(building)
	upgrade_window.visible = true

func on_upgrade_window_visibility_changed() -> void:
	get_tree().paused = upgrade_window.visible
	side_menu.pause_button.disabled = upgrade_window.visible
	if upgrade_window.visible:
		game_state = game_states.PAUSED
	else:
		game_state = game_states.RUNNING

func on_pause_requested(toggled: bool) -> void:
	if game_state in [game_states.PAUSED, game_states.RUNNING]:
		if toggled:
			game_state = game_states.PAUSED
		else:
			game_state = game_states.RUNNING
		pause_screen.visible = toggled
		get_tree().paused = toggled

func on_castle_destroyed() -> void:
	side_menu.pause_button.disabled = true
	game_state = game_states.OVER
	get_tree().paused = true
	game_over.set_game_over()
	game_over.visible = true
	wave_manager.spawn_cd.stop()

func on_quit_game_requested() -> void:
	get_tree().quit()
	
func on_new_game_requested() -> void:
	initialize()
	clear_board()
	game_over.visible = false
	get_tree().paused = false
