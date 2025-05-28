class_name RedGoblin
extends EnemyResource


func _init() -> void:
	# stats
	speed = 135.0
	damage = 30.0
	health = 48.0
	bounty = 5
	
	# visuals
	animation_name = "walking_red"
	outline_color = Color(1.0, 0.69, 0.69, 0)
