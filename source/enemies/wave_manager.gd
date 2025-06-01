class_name WaveManager
extends Node

signal wave_started
signal enemy_died
signal no_more_waves

var enemy_waves: Array[Dictionary] = EnemyWaves.new().enemy_waves
var enemy_path: Path2D
var initialized: bool = false
var spawn_cd: Timer = Timer.new()
var current_second: int
var current_wave: int
var waves_over: bool
var enemies_killed: int
var wave_info: Dictionary[int,Variant]
@onready var base_enemy: Enemy = preload("res://source/enemies/enemy.tscn").instantiate()

func _ready() -> void:
	add_child(spawn_cd)
	spawn_cd.timeout.connect(wave_tick)
	assert(initialized, "Please run initialize() before adding WaveManager to the scene tree")

func initialize(input_path: Path2D) -> void:
	spawn_cd.autostart = false
	spawn_cd.one_shot = false
	spawn_cd.wait_time = 1
	current_second = 0
	current_wave = 0
	enemies_killed = 0
	enemy_path = input_path
	waves_over = false
	initialized = true

func spawn_enemy(enemy_data) -> void:
	var enemy: Enemy = base_enemy.duplicate()
	enemy.died.connect(on_enemy_died)
	enemy.initialize(enemy_data)
	enemy_path.add_child(enemy)

func spawn_wave() -> void:
	if not waves_over:
		wave_info = enemy_waves[current_wave]
		var total_enemies: int = len(wave_info)
		spawn_cd.start()
		wave_started.emit(current_wave, total_enemies)

func wave_tick() -> void:
	current_second += 1
	if current_second in wave_info.keys():
		spawn_enemy(wave_info[current_second])
	if current_second >= wave_info.keys().max():
		wave_over()

func wave_over() -> void:
	current_wave += 1
	current_second = 0
	spawn_cd.stop()
	if current_wave >= enemy_waves.size():
		waves_over = true
		no_more_waves.emit()

func on_enemy_died() -> void:
	enemy_died.emit()
