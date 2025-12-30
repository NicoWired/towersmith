class_name DropControl
extends Control

signal building_requested

const XY_OFFSET: Vector2 = Vector2(64,0)

var points_to_check: Array
var occupied_areas: Array[CollisionShape2D]


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if "preview" in data:
		data["area"].scale = Vector2(5,5)
		points_to_check = data["shape_points"].map(func(x: Vector2): return x + at_position + global_position)
		for child in get_children():
			if child is DropArea:
				if child.try_drop_tower(points_to_check):
					if check_building_overlap():
						data["preview"].preview_image.modulate = Color.GREEN
						return true
	data["preview"].preview_image.modulate = Color.RED
	return false

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var new_building: Building = data["building"].instantiate()
	new_building.position = at_position + XY_OFFSET
	building_requested.emit(new_building, data["price"], at_position)

func get_occupied_areas() -> void:
	var buildings: Array[Node] = get_tree().get_nodes_in_group("buildings")
	occupied_areas = []
	for building: Node in buildings:
		occupied_areas.append(building.collision_shape_2d)

func check_building_overlap() -> bool:
	for building: CollisionShape2D in occupied_areas:
		for point: Vector2 in points_to_check:
			if building.shape.get_rect().has_point(building.to_local(point)):
				return false
	return true
