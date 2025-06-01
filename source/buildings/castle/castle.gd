class_name Castle
extends Node2D

signal castle_destroyed

const INITIAL_HEALTH: float = 200.0

var _health: float
var health: float:
	set(value):
		_health = value
		fire.visible = (health/INITIAL_HEALTH <= 0.75)
		fire_2.visible = (health/INITIAL_HEALTH <= 0.5)
		fire_3.visible = (health/INITIAL_HEALTH <= 0.25)
		if health <= 0:
			show_sprite(false)
			castle_destroyed.emit()
	get():
		return _health

@onready var hitbox: Area2D = $Hitbox
@onready var hitbox_shape: CollisionShape2D = $Hitbox/HitboxShape
@onready var castle_sprite: Sprite2D = $CastleSprite
@onready var castle_destroyed_sprite: Sprite2D = $CastleDestroyed
@onready var fire: AnimatedSprite2D = $CastleSprite/Fire
@onready var fire_2: AnimatedSprite2D = $CastleSprite/Fire2
@onready var fire_3: AnimatedSprite2D = $CastleSprite/Fire3



func _ready() -> void:
	hitbox.body_entered.connect(on_body_entered)
	show_sprite()
	for child in castle_sprite.get_children():
		if child is AnimatedSprite2D:
			child.play("fire")
	reset_health()

func reset_health() -> void:
	health = INITIAL_HEALTH

func show_sprite(healthy: bool = true) -> void:
	castle_sprite.visible = healthy
	castle_destroyed_sprite.visible = not healthy

func on_body_entered(body):
	if body.get_parent() is Enemy:
		var enemy: Enemy = body.get_parent()
		var damage_taken: float = enemy.deal_damage()
		take_damage(damage_taken)
		enemy.die()

func take_damage(damage: float) -> void:
	health -= damage
