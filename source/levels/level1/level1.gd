class_name level1
extends Node2D

var current_second: int = 0
var enemy_wave_1: Dictionary[int,Variant] = {
	1 : BlueGoblin
	,2 : BlueGoblin
	,3 : YellowGoblin
	,4 : BlueGoblin
	,5 : YellowGoblin
	,6 : BlueGoblin
	,7 : BlueGoblin
	,8 : YellowGoblin
	,9 : YellowGoblin
	,10 : RedGoblin
	,11 : YellowGoblin
	,12 : YellowGoblin
	,13 : BlueGoblin
	,14 : RedGoblin
	,15 : YellowGoblin
	,16 : BlueGoblin
	,17 : RedGoblin
	,18 : YellowGoblin
	,19 : YellowGoblin
	,20 : RedGoblin
}
var enemy_wave_2: Dictionary[int,Variant] = {
	1 : YellowGoblin
	,2 : BlueGoblin
	,3 : YellowGoblin
	,4 : BlueGoblin
	,5 : RedGoblin
	,6 : BlueGoblin
	,7 : YellowGoblin
	,8 : RedGoblin
	,9 : YellowGoblin
	,10 : RedGoblin
	,11 : RedGoblin
	,12 : YellowGoblin
	,13 : BlueGoblin
	,14 : RedGoblin
	,15 : YellowGoblin
	,16 : YellowGoblin
	,17 : RedGoblin
	,18 : RedGoblin
	,19 : YellowGoblin
	,20 : RedGoblin
}
var enemy_waves: Array[Dictionary] = [enemy_wave_1, enemy_wave_2]
var current_wave: int = 0

@onready var enemy_path: Path2D = $EnemyPath
@onready var enemy_spawn_cd: Timer = $EnemySpawnCD
@onready var gold_label: Label = $GoldLabel


func _ready() -> void:
	# Assign starting gold:
	Economy.current_gold += 200
	
	# spawn enemies
	enemy_spawn_cd.autostart = true
	enemy_spawn_cd.one_shot = false
	enemy_spawn_cd.wait_time = 1
	enemy_spawn_cd.timeout.connect(on_enemy_spawn_cd_timeout)
	enemy_spawn_cd.start()
	
	# connect signals
	GlobalEvents.buildings_changed.emit()
	Economy.gold_changed.connect(on_gold_changed)
	
	# update GUI
	on_gold_changed()

func on_enemy_spawn_cd_timeout() -> void:
	current_second += 1
	if current_second in enemy_waves[current_wave].keys():
		var enemy: Enemy = preload("res://source/enemies/enemy.tscn").instantiate()
		enemy.initialize(enemy_waves[current_wave][current_second])
		enemy_path.add_child(enemy)
	if current_second >= enemy_waves[current_wave].keys().max():
		current_wave += 1
		current_second = 0
		if current_wave >= enemy_waves.size():
			enemy_spawn_cd.stop()

func on_gold_changed() -> void:
	gold_label.text = "Gold: %s" % str(Economy.current_gold)
