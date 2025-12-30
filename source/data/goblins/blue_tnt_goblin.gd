class_name BlueTNTGoblin
extends EnemyResource


func _init() -> void:
	# stats
	speed = 170.0
	damage = 30.0
	health = 11.0
	bounty = 1
	
	# visuals
	animation_name = "walking_blue_tnt"
	outline_color = Color(0.69, 1.0, 0.69, 0)
