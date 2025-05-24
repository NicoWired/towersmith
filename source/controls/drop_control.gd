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
		show_error_text(at_position)
		return
	var new_tower: Tower = tower.duplicate()
	new_tower.position = at_position + XY_OFFSET
	new_tower.z_index = int(new_tower.global_position.y)
	Economy.current_gold -= data["price"]
	add_child(new_tower)
	get_occupied_areas()
	building_placed.emit(new_tower)

func get_occupied_areas() -> void:
	var buildings: Array[Node] = get_tree().get_nodes_in_group("buildings")
	occupied_areas = []
	for building: Node in buildings:
		occupied_areas.append(building.hitbox_shape)

func check_building_overlap() -> bool:
	for building: CollisionShape2D in occupied_areas:
		for point: Vector2 in points_to_check:
			if building.shape.get_rect().has_point(building.to_local(point)):
				return false
	return true

func show_error_text(at_position: Vector2) -> void:
	var error_label := Label.new()
	error_label.text = "not enough gold"
	error_label.modulate = Color(1, 0.2, 0.2, 1)
	error_label.add_theme_font_size_override("font_size", 24)
	error_label.position = at_position
	add_child(error_label)

	var tween := create_tween()
	tween.tween_property(error_label, "position:y", error_label.position.y - 40, 1.2)
	tween.tween_property(error_label, "modulate:a", 0, 1.2)
	tween.finished.connect(error_label.queue_free)
