extends Node

func _ready() -> void:
	# config viewport
	get_window().position += Vector2i(0,32)
	get_viewport().size = Vector2(1280,720)
	
	# setup custom cursor art
	var needed_cursors: Array[int] = [
		Input.CursorShape.CURSOR_ARROW,
		Input.CursorShape.CURSOR_CAN_DROP,
		Input.CursorShape.CURSOR_FORBIDDEN
	]
	for cursor_shape in needed_cursors:
		Input.set_custom_mouse_cursor(LoadAssets.sprites["cursor"], cursor_shape)

func _process(_delta: float) -> void:
	$FPSCounter.text = str(Engine.get_frames_per_second())
