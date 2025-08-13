class_name EnemyResource
extends Node

# stats
var speed: float
var damage: float
var health: float 
var bounty: int

# visuals
var animation_name: StringName
var outline_color: Color

func _init() -> void:
	assert(speed and damage and health and animation_name and outline_color and bounty
		, "Values for EnemyResource not properly set")
