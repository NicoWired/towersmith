class_name Enemy
extends PathFollow2D

# stats
var speed: float
var damage: float
var health: float 

# visuals
var animation_name: StringName
var outline_color: Color

var previous_x: float
var initialized: bool = false
@onready var enemy_animation: AnimatedSprite2D = $Body/AnimatedSprite2D
@onready var body: CharacterBody2D = $Body

func _ready() -> void:
	assert(initialized, "Please initialize the enemy with an EnemyResource")
	enemy_animation.play(animation_name)
	enemy_animation.material = enemy_animation.material.duplicate()
	enemy_animation.material.set_shader_parameter("color",outline_color)

func _process(delta: float) -> void:
	progress += speed * delta
	var current_x: float = position.x
	if current_x < previous_x:
		enemy_animation.flip_h = true
	elif current_x > previous_x:
		enemy_animation.flip_h = false
	previous_x = current_x

func initialize(init_values) -> void:
	var enemy_resources: EnemyResource = init_values.new()
	speed = enemy_resources.speed
	damage = enemy_resources.damage
	health = enemy_resources.health
	animation_name = enemy_resources.animation_name
	outline_color = enemy_resources.outline_color
	initialized = true

func deal_damage() -> float:
	return damage

func take_damage(damage_taken: float) -> void:
	health -= damage_taken
	if health <= 0:
		queue_free()
