class_name ShootingSystem
extends Node2D

var projectile_on_cd: bool = false
var arrow_scene: PackedScene = preload("res://source/projectiles/Arrow.tscn")
@onready var cooldown: Timer = $Cooldown


func _ready() -> void:
	cooldown.autostart = false
	cooldown.one_shot = true
	cooldown.timeout.connect(func(): projectile_on_cd = false)

func shoot(projectile_stats: ArrowStats, target: Vector2) -> void:
	if not projectile_on_cd:
		var arrow: Arrow = arrow_scene.instantiate()
		var arrow_direction: Vector2 = target - global_position
		arrow.rotation = arrow_direction.angle()
		arrow.initialize(projectile_stats, arrow_direction.normalized())
		call_deferred("add_child", arrow)
		projectile_on_cd = true
		cooldown.start()
