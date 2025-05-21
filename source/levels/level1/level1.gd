class_name level1
extends Node2D

enum game_states {
	INITIAL,
	RUNNING,
	PAUSED,
	OVER
}

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
	# assign starting gold:
	Economy.current_gold += 200
	
	# update location of starting buildings
	drop_control.get_occupied_areas()
	
	# spawn enemies
	wave_manager.initialize(enemy_path)
	add_child(wave_manager)
	wave_manager.spawn_cd.start()
	
	# connect signals
	Economy.gold_changed.connect(on_gold_changed)
	drop_control.building_placed.connect(on_building_placed)
	upgrade_window.visibility_changed.connect(on_upgrade_window_visibility_changed)
	side_menu.pause_requested.connect(on_pause_requested)
	castle.castle_destroyed.connect(on_castle_destroyed)
	
	# update GUI
	upgrade_window.visible = false
	on_gold_changed()
	
	# play music
	#bgm.play()
	#side_menu.mute_button.button_pressed = true
	
	# start game
	game_state = game_states.RUNNING


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
