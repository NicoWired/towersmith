class_name WaveManager
extends Node

signal no_more_waves

var enemy_waves: Array[Dictionary] = EnemyWaves.new().enemy_waves
var enemy_path: Path2D
var initialized: bool = false
var spawn_cd: Timer = Timer.new()
var current_second: int
var current_wave: int
var waves_over: bool
var enemies_killed: int
@onready var base_enemy: Enemy = preload("res://source/enemies/enemy.tscn").instantiate()

func _ready() -> void:
	add_child(spawn_cd)
	spawn_cd.timeout.connect(spawn_enemy)
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

func spawn_enemy() -> void:
	if not waves_over:
		current_second += 1
		if current_second in enemy_waves[current_wave].keys():
			var enemy: Enemy = base_enemy.duplicate()
			enemy.died.connect(on_enemy_died)
			enemy.initialize(enemy_waves[current_wave][current_second])
			enemy_path.add_child(enemy)
		if current_second >= enemy_waves[current_wave].keys().max():
			current_wave += 1
			current_second = 0
			if current_wave >= enemy_waves.size():
				waves_over = true
				no_more_waves.emit()
				spawn_cd.stop()

func on_enemy_died() -> void:
	pass
