class_name Arrow
extends CharacterBody2D

# stats
var damage: float
var speed: float

var direction: Vector2
var initialized: bool = false

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var area_2d: Area2D = $Area2D


func _ready() -> void:
	assert(initialized, "Please initialize the arrow before using it")
	area_2d.add_child(collision_shape_2d.duplicate())
	area_2d.body_entered.connect(on_body_entered)

func _process(delta: float) -> void:
	position += speed * delta * direction

func initialize(
		input_damage: float
		,input_direction: Vector2
		,input_speed
		) -> void:
	damage = input_damage
	speed = input_speed
	direction = input_direction
	initialized = true

func on_body_entered(body) -> void:
	print("arrow hit")
	var enemy: Enemy = body.get_parent()
	enemy.take_damage(damage)
