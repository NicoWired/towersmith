class_name Tower
extends Building

var target: Vector2
var building_stats: TowerStats = TowerStats.new()
var arrow_stats: ArrowStats = building_stats.arrow_stats

@onready var targetting_system: TargettingSystem = $TargettingSystem
@onready var shooting_system: ShootingSystem = $ShootingSystem

func _ready() -> void:
	super._ready()
	set_building_stats()
	area_2d.position.y += 64

func _process(_delta: float) -> void:
	if len(targetting_system.target_list) > 0 and not shooting_system.projectile_on_cd:
		target = targetting_system.lock_target()
		shooting_system.shoot(arrow_stats, target)

func set_building_stats() -> void:
	targetting_system.update_range(building_stats.get_tower_range())

func on_upgrade_requested() -> void:
	upgrade_requested.emit(self)
