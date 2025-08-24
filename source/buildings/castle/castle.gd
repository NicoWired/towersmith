class_name Castle
extends Building

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
			show_destroyed_sprite()
			castle_destroyed.emit()
	get():
		return _health
		
@onready var hitbox_area: Area2D = $HitboxArea
@onready var destroyed_sprite: Sprite2D = $DestroyedSprite
@onready var fire: AnimatedSprite2D = $FireAnimations/Fire
@onready var fire_2: AnimatedSprite2D = $FireAnimations/Fire2
@onready var fire_3: AnimatedSprite2D = $FireAnimations/Fire3
@onready var fire_animations: Node2D = $FireAnimations

func _ready() -> void:
	super._ready()
	area_2d.collision_layer = 17
	area_2d.collision_mask = 20
	
	hitbox_area.body_entered.connect(on_body_entered)
	show_destroyed_sprite(false)
	for child in fire_animations.get_children():
		if child is AnimatedSprite2D:
			child.play("fire")
	fire_animations.move_to_front()
	reset_health()

func reset_health() -> void:
	health = INITIAL_HEALTH

func show_destroyed_sprite(destroyed: bool = true) -> void:
	main_sprite.visible = not destroyed
	destroyed_sprite.visible = destroyed

func on_body_entered(body):
	if body.get_parent() is Enemy:
		var enemy: Enemy = body.get_parent()
		var damage_taken: float = enemy.deal_damage()
		take_damage(damage_taken)
		enemy.die()

func take_damage(damage: float) -> void:
	health -= damage
