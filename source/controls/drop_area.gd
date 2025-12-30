class_name DropArea
extends Area2D

var polygon_global_position: PackedVector2Array = []

func _ready() -> void:
	for polygon_point in $CollisionPolygon2D.polygon:
		polygon_global_position.append($CollisionPolygon2D.to_global(polygon_point))

func try_drop_tower(points_to_check: Array) -> bool:
	for point:Vector2 in points_to_check:
		if not Geometry2D.is_point_in_polygon(point, polygon_global_position):
			return false
	return true
