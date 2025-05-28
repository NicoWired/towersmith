class_name WaveAnalyzer 
extends Node

var wave_data: EnemyWaves = EnemyWaves.new()

func _ready() -> void:
	get_viewport().size = Vector2(1,1)
	analyze_all_waves()

func analyze_all_waves() -> void:
	for i in range(wave_data.enemy_waves.size()):
		print("=== Wave %d Analysis ===" % (i + 1))
		var stats: Dictionary[StringName,Variant] = calculate_wave_stats(wave_data.enemy_waves[i])
		print_wave_stats(stats)
		print()

func calculate_wave_stats(wave: Dictionary[int,Variant]) -> Dictionary[StringName,Variant]:
	var total_enemies: int = 0
	var total_health: float = 0.0
	var total_bounty: int = 0
	var total_damage: float = 0.0
	var total_speed: float = 0.0
	
	for second: int in wave.keys():
		var enemy_class: GDScript = wave[second]
		var enemy_instance: EnemyResource = enemy_class.new()
		
		total_enemies += 1
		total_health += enemy_instance.health
		total_bounty += enemy_instance.bounty
		total_damage += enemy_instance.damage
		total_speed += enemy_instance.speed
		
		enemy_instance.queue_free()
	
	var average_speed: float = total_speed / total_enemies if total_enemies > 0 else 0.0
	
	return {
		"total_enemies": total_enemies,
		"total_health": total_health,
		"total_bounty": total_bounty,
		"total_damage": total_damage,
		"average_speed": average_speed
	}

func print_wave_stats(stats: Dictionary[StringName,Variant]) -> void:
	print("Total enemies: %d" % stats.total_enemies)
	print("Total health: %.1f" % stats.total_health)
	print("Total bounty: %d" % stats.total_bounty)
	print("Total damage: %.1f" % stats.total_damage)
	print("Average speed: %.1f" % stats.average_speed)
