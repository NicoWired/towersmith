class_name level1
extends Node2D

enum game_states {
	INITIAL,
	RUNNING,
	OVER
}

const INITIAL_GOLD: int = 200

var current_wave: int
var game_state: int = game_states.INITIAL
var wave_manager: WaveManager = WaveManager.new()
#var _gold: int
#var gold: int:
	#set(value):
		#_gold = value
	#get():
		#return _gold


@onready var enemy_path: Path2D = $EnemyPath
@onready var upgrade_window: Control = $UpgradeWindow
@onready var drop_control: DropControl = $DropControl
@onready var side_menu: SideMenu = $SideMenu
@onready var bgm: AudioStreamPlayer = $BGM
@onready var pause_screen: Panel = $PauseScreen
@onready var game_over: GameOver = $GameOver
@onready var castle: Castle = $Buildings/Castle
@onready var wave_indicator: Label = $WaveIndicator
@onready var buildings: Node2D = $Buildings



func _ready() -> void:
	# update location of starting buildings
	drop_control.get_occupied_areas()
	
	# connect signals
	Economy.gold_changed.connect(on_gold_changed)
	drop_control.building_requested.connect(on_building_requested)
	upgrade_window.visibility_changed.connect(on_upgrade_window_visibility_changed)
	side_menu.pause_requested.connect(on_pause_requested)
	side_menu.play_requested.connect(start_wave)
	castle.castle_destroyed.connect(on_castle_destroyed)
	wave_manager.wave_started.connect(on_wave_started)
	wave_manager.wave_finished.connect(on_wave_finished)
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
	#gold = INITIAL_GOLD
	wave_manager.initialize(enemy_path)
	side_menu.pause_button.disabled = true
	game_state = game_states.INITIAL
	current_wave = 0
	update_wave_indicator()
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
	drop_control.get_occupied_areas()

func start_wave() -> void:
	side_menu.pause_button.disabled = false
	if game_state == game_states.INITIAL:
		game_state = game_states.RUNNING
		wave_manager.spawn_wave()

func on_gold_changed() -> void:
	side_menu.set_gold_label(Economy.current_gold)
	
func on_building_upgrade_requested(building: Tower) -> void:
	upgrade_window.update(building)
	upgrade_window.visible = true

func on_upgrade_window_visibility_changed() -> void:
	get_tree().paused = upgrade_window.visible
	side_menu.pause_button.disabled = upgrade_window.visible

func on_pause_requested(toggled: bool) -> void:
	if game_state == game_states.RUNNING:
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

func on_wave_started(new_wave: int) -> void:
	current_wave = new_wave
	update_wave_indicator()
	game_state = game_states.RUNNING

func on_wave_finished() -> void:
	game_state = game_states.INITIAL

func update_wave_indicator() -> void:
	wave_indicator.text = "Current wave: %s" % str(current_wave+1)

func on_building_requested(new_building, building_price, error_position):
	if Economy.current_gold < building_price:
		show_error_text(error_position)
		return
	new_building.z_index = int(new_building.global_position.y)
	Economy.current_gold -= building_price
	buildings.add_child(new_building)
	new_building.upgrade_requested.connect(on_building_upgrade_requested)
	drop_control.get_occupied_areas()

func show_error_text(at_position: Vector2) -> void:
	var error_label := Label.new()
	error_label.text = "not enough gold"
	error_label.modulate = Color(1, 0.2, 0.2, 1)
	error_label.add_theme_font_size_override("font_size", 24)
	error_label.position = at_position
	add_child(error_label)

	var tween := create_tween()
	tween.tween_property(error_label, "position:y", error_label.position.y - 40, 1.2)
	tween.tween_property(error_label, "modulate:a", 0, 1.2)
	tween.finished.connect(error_label.queue_free)
