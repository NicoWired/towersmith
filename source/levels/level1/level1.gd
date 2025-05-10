class_name level1
extends Node2D

var current_second: int = 0
var enemy_wave: Dictionary = {
	1 : BlueGoblin
	,2 : BlueGoblin
	,3 : YellowGoblin
	,4 : BlueGoblin
	,5 : YellowGoblin
	,6 : BlueGoblin
	,7 : BlueGoblin
	,8 : YellowGoblin
	,9 : YellowGoblin
	,10 : BlueGoblin
	,11 : YellowGoblin
	,12 : YellowGoblin
	,13 : BlueGoblin
	,14 : YellowGoblin
	,15 : YellowGoblin
	,16 : BlueGoblin
	,17 : BlueGoblin
	,18 : YellowGoblin
	,19 : YellowGoblin
	,20 : BlueGoblin
}

@onready var enemy_path: Path2D = $EnemyPath
@onready var enemy_spawn_cd: Timer = $EnemySpawnCD


func _ready() -> void:
	enemy_spawn_cd.autostart = true
	enemy_spawn_cd.one_shot = false
	enemy_spawn_cd.wait_time = 1
	enemy_spawn_cd.timeout.connect(on_enemy_spawn_cd_timeout)
	enemy_spawn_cd.start()
	GlobalEvents.buildings_changed.emit()

func on_enemy_spawn_cd_timeout() -> void:
	current_second += 1
	if current_second in enemy_wave.keys():
		var enemy: Enemy = preload("res://source/enemies/enemy.tscn").instantiate()
		enemy.initialize(enemy_wave[current_second])
		enemy_path.add_child(enemy)
