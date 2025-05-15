class_name Arrow
extends CharacterBody2D

var arrow_stats: ArrowStats
var direction: Vector2
var initialized: bool = false
var has_hit: bool = false

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var area_2d: Area2D = $Area2D


func _ready() -> void:
	assert(initialized, "Please initialize the arrow before using it")
	area_2d.add_child(collision_shape_2d.duplicate())
	area_2d.body_entered.connect(on_body_entered)

func _process(delta: float) -> void:
	position += arrow_stats.get_speed() * delta * direction

func initialize(input_stats: ArrowStats, arrow_direction: Vector2) -> void:
	arrow_stats = input_stats
	direction = arrow_direction
	initialized = true

func on_body_entered(body) -> void:
	if not has_hit:
		has_hit = true
		var enemy: Enemy = body.get_parent()
		enemy.take_damage(arrow_stats.get_damage())
		queue_free()
