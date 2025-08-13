class_name Enemy
extends PathFollow2D

signal died

# stats
var speed: float
var damage: float
var health: float 
var bounty: int

# visuals
var animation_name: StringName
var outline_color: Color

var previous_x: int
var previous_y: float
var initialized: bool = false
@onready var enemy_animation: AnimatedSprite2D = $Body/AnimatedSprite2D
@onready var body: CharacterBody2D = $Body

func _ready() -> void:
	assert(initialized, "Please initialize the enemy with an EnemyResource")
	enemy_animation.play(animation_name)
	enemy_animation.material = enemy_animation.material.duplicate()
	enemy_animation.material.set_shader_parameter("color",outline_color)

func _process(delta: float) -> void:
	# move along the road
	progress += speed * delta
	
	# flip sprite if X direction changed
	var current_x: int = int(position.x)
	if current_x < previous_x:
		enemy_animation.flip_h = true
	elif current_x > previous_x:
		enemy_animation.flip_h = false
	previous_x = current_x
	
	# update z_index if Y changed
	var current_y: float = position.y
	if current_y != previous_y:
		z_index = int(global_position.y)
	previous_y = current_y

func initialize(init_values) -> void:
	var enemy_resources: EnemyResource = init_values.new()
	speed = enemy_resources.speed
	damage = enemy_resources.damage
	health = enemy_resources.health
	bounty = enemy_resources.bounty
	animation_name = enemy_resources.animation_name
	outline_color = enemy_resources.outline_color
	initialized = true

func deal_damage() -> float:
	return damage

func take_damage(damage_taken: float) -> void:
	health -= damage_taken
	if health <= 0:
		Economy.current_gold += bounty
		die()

func die() -> void:
	died.emit()
	queue_free()
