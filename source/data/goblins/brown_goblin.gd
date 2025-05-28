class_name BrownGoblin
extends EnemyResource


func _init() -> void:
	# stats
	speed = 155.0
	damage = 75.0
	health = 170.0
	bounty = 14
	
	# visuals
	animation_name = "walking_brown"
	outline_color = Color(1.0, 0.69, 0.69, 0)
