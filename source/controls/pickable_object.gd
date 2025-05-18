class_name PickableObject
extends Control

const SPRITE_DIMENSIONS: int = 128
const PRICE: int = 60
const HITBOX_TOLERANCE:int = 16 # pixels allowed to overlap with other objects

var min_coords: Vector2i = Vector2i.ZERO + Vector2i(HITBOX_TOLERANCE,HITBOX_TOLERANCE)
var max_coords: Vector2i = Vector2i(SPRITE_DIMENSIONS,SPRITE_DIMENSIONS) - Vector2i(HITBOX_TOLERANCE,HITBOX_TOLERANCE)

@warning_ignore("integer_division")
var shape_points: Array[Vector2] = [
	Vector2(min_coords.x,min_coords.y),
	Vector2(min_coords.x,max_coords.y),
	Vector2(max_coords.x,min_coords.y),
	Vector2(max_coords.x,max_coords.y),
	Vector2(max_coords.x/2,max_coords.y/2)
]
@onready var preview_image: Sprite2D = $Sprite2D


func _get_drag_data(at_position: Vector2) -> Variant:
	var preview: PickableObject = self.duplicate()
	set_deferred("preview.preview_image.modulate", Color.RED)
	set_drag_preview(preview)
	return(
		{
			"position": at_position,
			"preview": preview,
			"size": Vector2(128,128),
			"offset": Vector2(0,64),
			"shape_points": shape_points,
			"area": $Sprite2D/Area2D.duplicate(),
			"price": PRICE
		}
	)
