extends Node

func _ready() -> void:
	get_window().position += Vector2i(0,32)
	get_viewport().size = Vector2(1280,720)
	pass

func _process(_delta: float) -> void:
	$FPSCounter.text = str(Engine.get_frames_per_second())
