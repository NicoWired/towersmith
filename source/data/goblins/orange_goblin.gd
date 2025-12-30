class_name OrangeGoblin
extends EnemyResource


func _init() -> void:
	# stats
	speed = 150.0
	damage = 60.0
	health = 130.0
	bounty = 10
	
	# visuals
	animation_name = "walking_orange"
	outline_color = Color(1.0, 0.69, 0.69, 0)
