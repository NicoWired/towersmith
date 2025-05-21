class_name Castle
extends Node2D

signal castle_destroyed

var health: float = 200.0
var initial_health = health
@onready var hitbox: Area2D = $Hitbox
@onready var hitbox_shape: CollisionShape2D = $Hitbox/HitboxShape
@onready var castle_sprite: Sprite2D = $CastleSprite
@onready var castle_destroyed_sprite: Sprite2D = $CastleDestroyed
@onready var fire: AnimatedSprite2D = $CastleSprite/Fire
@onready var fire_2: AnimatedSprite2D = $CastleSprite/Fire2
@onready var fire_3: AnimatedSprite2D = $CastleSprite/Fire3



func _ready() -> void:
	hitbox.body_entered.connect(on_body_entered)
	for child in castle_sprite.get_children():
		if child is AnimatedSprite2D:
			child.play("fire")
	
func on_body_entered(body):
	if body.get_parent() is Enemy:
		var enemy: Enemy = body.get_parent()
		var damage_taken: float = enemy.deal_damage()
		take_damage(damage_taken)
		enemy.queue_free()

func take_damage(damage: float) -> void:
	health -= damage
	if health/initial_health <= 0.75:
		fire.visible = true
	if health/initial_health <= 0.5:
		fire_2.visible = true
	if health/initial_health <= 0.25:
		fire_3.visible = true
	if health <= 0:
		castle_sprite.visible = false
		castle_destroyed_sprite.visible = true
		castle_destroyed.emit()
