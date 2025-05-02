class_name Tower
extends Sprite2D

# stats
var damage: float = 10.0
var tower_range: float = 150.0
var projectile_speed: float = 5.0
#var aspd: float = 

var arrow_scene: PackedScene = preload("res://source/projectiles/Arrow.tscn")
var arrow_on_cd: bool = false
var target_list: Array[CharacterBody2D] = []
var target: CharacterBody2D
var arrow_direction: Vector2

@onready var range_area: Area2D = $RangeArea
@onready var collision_shape_2d: CollisionShape2D = $RangeArea/CollisionShape2D
@onready var arrow_cd_timer: Timer = $ArrowCDTimer


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
	arrow.initialize(damage, arrow_direction, projectile_speed)
	call_deferred("add_child", arrow)
	arrow_on_cd = true
	arrow_cd_timer.start() 

func acquire_target() -> CharacterBody2D:
	var chosen_target: CharacterBody2D
	chosen_target = target_list.pick_random()
	return chosen_target
