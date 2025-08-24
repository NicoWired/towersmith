class_name PickableObject
extends Control


const HITBOX_TOLERANCE:int = 16 # pixels allowed to overlap with other objects

var shape_points: Array[Vector2]

@onready var area_2d: Area2D = $Sprite2D/Area2D
@onready var preview_image: Sprite2D = $Sprite2D

@export var building: PackedScene
@export var price: int

func _ready() -> void:
	mouse_filter = MOUSE_FILTER_STOP
	shape_points = get_shape_points()

func get_shape_points() -> Array[Vector2]:
	var sprite_shape: Shape2D = building.instantiate().hitbox_shape
	var min_coords: Vector2 = Vector2.ZERO + Vector2(HITBOX_TOLERANCE,HITBOX_TOLERANCE)
	var max_coords: Vector2 = sprite_shape.size - Vector2(HITBOX_TOLERANCE,HITBOX_TOLERANCE)
	return [
		Vector2(min_coords.x,min_coords.y),
		Vector2(min_coords.x,max_coords.y),
		Vector2(max_coords.x,min_coords.y),
		Vector2(max_coords.x,max_coords.y),
		Vector2(max_coords.x/2,max_coords.y/2)
	]

#func _gui_input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		#print("Mouse event - pressed:", event.pressed, "button_index:", event.button_index)
		#if event.pressed:
			#print("force_drag called from node:", name)
			#force_drag({
				#"size": Vector2(128,128),
				#"offset": Vector2(0,64),
				#"shape_points": shape_points,
				#"area": $Sprite2D/Area2D.duplicate(),
				#"price": PRICE,
				#"preview": self.duplicate()
			#},self.duplicate())

func _get_drag_data(_at_position: Vector2) -> Variant:
	var preview: PickableObject = self.duplicate()
	set_drag_preview(preview)
	return(
		{
			"preview": preview,
			"size": Vector2(128,128),
			"offset": Vector2(0,64),
			"shape_points": shape_points,
			"area": $Sprite2D/Area2D.duplicate(),
			"price": price,
			"building": building
		}
	)

#func _notification(what: int) -> void:
	#if what == NOTIFICATION_DRAG_BEGIN:
		#print("Drag operation started")
	#elif what == NOTIFICATION_DRAG_END:
		#print("Drag operation ended, successful:", is_drag_successful())
