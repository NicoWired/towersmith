class_name Enemy
extends PathFollow2D

# stats
var speed: float = 300.0
var damage: float = 10.0

var previous_x: float
@onready var animation: AnimatedSprite2D = $Body/AnimatedSprite2D
@onready var body: CharacterBody2D = $Body


func _process(delta: float) -> void:
	progress += speed * delta
	var current_x: float = position.x
	if current_x < previous_x:
		animation.flip_h = true
	elif current_x > previous_x:
		animation.flip_h = false
	previous_x = current_x

func deal_damage() -> float:
	return damage
