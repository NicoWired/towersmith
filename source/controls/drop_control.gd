class_name DropControl
extends Control

signal building_placed

const XY_OFFSET: Vector2 = Vector2(64,0)

var tower: Tower = preload("res://source/buildings/towers/Tower.tscn").instantiate()
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
	if Economy.current_gold < data["price"]:
		print("not enough gold")
		return
	var new_tower: Tower = tower.duplicate()
	new_tower.position = at_position + XY_OFFSET
	new_tower.z_index = int(new_tower.global_position.y)
	Economy.current_gold -= data["price"]
	add_child(new_tower)
	get_occupied_areas()
	building_placed.emit(new_tower)

func get_occupied_areas():
	var buildings: Array[Node] = get_tree().get_nodes_in_group("buildings")
	for building: Node in buildings:
		occupied_areas.append(building.hitbox_shape)

func check_building_overlap() -> bool:
	for building: CollisionShape2D in occupied_areas:
		for point: Vector2 in points_to_check:
			if building.shape.get_rect().has_point(building.to_local(point)):
				return false
	return true
