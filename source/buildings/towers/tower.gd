class_name Tower
extends Sprite2D

signal upgrade_requested

# stats
var building_stats: TowerStats = TowerStats.new()
var arrow_stats: ArrowStats = building_stats.arrow_stats

# targeting
var target: Vector2

@onready var hitbox: Area2D = $Hitbox
@onready var hitbox_shape: CollisionShape2D = $Hitbox/HitboxShape
@onready var tower_click: TextureButton = $TowerClick
@onready var hover_shader: Material = material
@onready var targetting_system: TargettingSystem = $TargettingSystem
@onready var shooting_system: ShootingSystem = $ShootingSystem


func _ready() -> void:
	set_building_stats()
	material = null
	
	# connect signals
	tower_click.pressed.connect(on_upgrade_requested)
	tower_click.mouse_entered.connect(on_tower_hovered_in)
	tower_click.mouse_exited.connect(on_tower_hovered_out)


func _process(_delta: float) -> void:
	if len(targetting_system.target_list) > 0 and not shooting_system.projectile_on_cd:
		target = targetting_system.lock_target()
		shooting_system.shoot(arrow_stats, target)

func set_building_stats() -> void:
	targetting_system.update_range(building_stats.get_tower_range())

func on_upgrade_requested() -> void:
	upgrade_requested.emit(self)

func on_tower_hovered_in() -> void:
	material = hover_shader
	
func on_tower_hovered_out() -> void:
	material = null
