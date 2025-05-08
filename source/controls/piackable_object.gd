class_name PickableObject
extends Control

const SPRITE_DIMENSIONS: int = 128

@warning_ignore("integer_division")
var shape_points: Array[Vector2] = [
	Vector2(0,0),
	Vector2(0,SPRITE_DIMENSIONS),
	Vector2(SPRITE_DIMENSIONS,0),
	Vector2(SPRITE_DIMENSIONS,SPRITE_DIMENSIONS),
	Vector2(SPRITE_DIMENSIONS/2,SPRITE_DIMENSIONS/2)
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
			"area": $Sprite2D/Area2D.duplicate()
		}
	)
