extends Node

var sprites: Dictionary[StringName,Texture]

func _ready() -> void:
	sprites["cursor"] = preload("res://assets/tiny_swords/UI/Pointers/01_cropped.png")
