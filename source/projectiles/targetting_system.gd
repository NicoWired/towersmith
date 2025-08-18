class_name TargettingSystem
extends Node2D

enum targetting_methods {
	RANDOM
}

var target_list: Array = []

@onready var range_area: Area2D = $RangeArea
@onready var range_shape: CollisionShape2D = $RangeArea/RangeShape
@export var radius: float = 150.0


func _ready() -> void:
	range_area.body_entered.connect(on_body_entered)
	range_area.body_exited.connect(on_body_exited)
	range_shape.shape.radius = radius

func on_body_entered(body) -> void:
	target_list.append(body)

func on_body_exited(body) -> void:
	var target_index: int = target_list.find(body)
	if target_index >= 0:
		target_list.remove_at(target_index)

func update_range(new_range: float) -> void:
	range_shape.shape.radius = new_range

func lock_target(method: int = targetting_methods.RANDOM) -> Vector2:
	match method:
		targetting_methods.RANDOM: return random_acquisition()
		_: return Vector2.ZERO
	
func random_acquisition() -> Vector2:
	if target_list.is_empty():
		return Vector2.ZERO
	var chosen_enemy: CharacterBody2D = target_list.pick_random()
	return chosen_enemy.global_position
	
	
