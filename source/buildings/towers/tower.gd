class_name Tower
extends Sprite2D

# arrow stats
var arrow_stats: ArrowStats = ArrowStats.new()

# tower stats
var aspd: float
var tower_range: float = 150.0

# arrows
var arrow_scene: PackedScene = preload("res://source/projectiles/Arrow.tscn")
var arrow_on_cd: bool = false
var arrow_direction: Vector2

# targeting
var target_list: Array[CharacterBody2D] = []
var target: CharacterBody2D

@onready var range_area: Area2D = $RangeArea
@onready var collision_shape_2d: CollisionShape2D = $RangeArea/CollisionShape2D
@onready var arrow_cd_timer: Timer = $ArrowCDTimer
@onready var hitbox: Area2D = $Hitbox
@onready var hitbox_shape: CollisionShape2D = $Hitbox/HitboxShape


func _ready() -> void:
	collision_shape_2d.shape.radius = tower_range
	range_area.body_entered.connect(on_body_entered)
	range_area.body_exited.connect(on_body_exited)
	arrow_cd_timer.timeout.connect(on_timer_timeout)

func _process(_delta: float) -> void:
	if len(target_list) > 0 and not arrow_on_cd:
		target = acquire_target()
		shoot_arrow()

func on_body_entered(body) -> void:
	target_list.append(body)

func on_body_exited(body) -> void:
	var target_index: int = target_list.find(body)
	if target_index >= 0:
		target_list.remove_at(target_index)

func on_timer_timeout() -> void:
	arrow_on_cd = false

func shoot_arrow() -> void:
	var arrow: Arrow = arrow_scene.instantiate()
	arrow_direction = target.global_position - global_position
	arrow.rotation = arrow_direction.angle()
	arrow.initialize(arrow_stats, arrow_direction)
	call_deferred("add_child", arrow)
	arrow_on_cd = true
	arrow_cd_timer.start() 

func acquire_target() -> CharacterBody2D:
	var chosen_target: CharacterBody2D
	chosen_target = target_list.pick_random()
	return chosen_target
