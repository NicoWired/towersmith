extends Sprite2D

var health: float = 500.0
@onready var hitbox: Area2D = $Hitbox
@onready var hitbox_shape: CollisionShape2D = $Hitbox/HitboxShape

func _ready() -> void:
	hitbox.body_entered.connect(on_body_entered)
	
func on_body_entered(body):
	if body.get_parent() is Enemy:
		var enemy: Enemy = body.get_parent()
		var damage_taken: float = enemy.deal_damage()
		take_damage(damage_taken)
		enemy.queue_free()

func take_damage(damage: float) -> void:
	health -= damage
	if health <= 0:
		print("game over")
		queue_free()
