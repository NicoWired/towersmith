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
#
func _ready() -> void:
	mouse_filter = MOUSE_FILTER_STOP
#
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
			"price": PRICE
		}
	)

func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_BEGIN:
		print("Drag operation started")
	elif what == NOTIFICATION_DRAG_END:
		print("Drag operation ended, successful:", is_drag_successful())
