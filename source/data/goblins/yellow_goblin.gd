class_name YellowGoblin
extends EnemyResource


func _init() -> void:
	# stats
	speed = 125.0
	damage = 15.0
	health = 23.0
	bounty = 2
	
	# visuals
	animation_name = "walking_yellow"
	outline_color = Color(1.0, 0.69, 0.69, 0)
