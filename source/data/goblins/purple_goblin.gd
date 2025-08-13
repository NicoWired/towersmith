class_name PurpleGoblin
extends EnemyResource


func _init() -> void:
	# stats
	speed = 145.0
	damage = 45.0
	health = 85.0
	bounty = 7
	
	# visuals
	animation_name = "walking_purple"
	outline_color = Color(1.0, 0.69, 0.69, 0)
