class_name BlueGoblin
extends EnemyResource


func _init() -> void:
	# stats
	speed = 100.0
	damage = 10.0
	health = 15.0
	bounty = 1
	
	# visuals
	animation_name = "walking_blue"
	outline_color = Color(0.69, 1.0, 0.69, 0)
