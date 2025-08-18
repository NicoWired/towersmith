@tool
class_name Building
extends Node2D

var main_sprite: Sprite2D
var area_2d: Area2D
var collision_shape_2d: CollisionShape2D

var _main_texture: Texture2D
@export var main_texture: Texture2D:
	set(value):
		_main_texture = value
		if is_instance_valid(main_sprite):
			main_sprite.texture = value
	get:
		return _main_texture

var _hitbox_shape: Shape2D
@export var hitbox_shape: Shape2D:
	set(value):
		_hitbox_shape = value
		if is_instance_valid(collision_shape_2d):
			collision_shape_2d.shape = value
	get:
		return _hitbox_shape


func _enter_tree() -> void:
	# Sprite: reuse or create
	main_sprite = get_node_or_null("MainSprite") as Sprite2D
	if main_sprite == null:
		main_sprite = Sprite2D.new()
		main_sprite.name = "MainSprite"
		add_child(main_sprite)
		if Engine.is_editor_hint():
			main_sprite.owner = self
	if _main_texture:
		main_sprite.texture = _main_texture

	# Area2D: reuse by name, then by first Area2D child, else create
	area_2d = get_node_or_null("HitboxArea") as Area2D
	if area_2d == null:
		for child in get_children():
			if child is Area2D:
				area_2d = child
				break
	if area_2d == null:
		area_2d = Area2D.new()
		area_2d.name = "HitboxArea"
		add_child(area_2d)
		if Engine.is_editor_hint():
			area_2d.owner = self

	# CollisionShape2D: reuse by name, then first under Area2D, else create
	if area_2d:
		collision_shape_2d = area_2d.get_node_or_null("HitboxCollisionShape") as CollisionShape2D
		if collision_shape_2d == null:
			for child in area_2d.get_children():
				if child is CollisionShape2D:
					collision_shape_2d = child
					break
		if collision_shape_2d == null:
			collision_shape_2d = CollisionShape2D.new()
			collision_shape_2d.name = "HitboxCollisionShape"
			area_2d.add_child(collision_shape_2d)
			if Engine.is_editor_hint():
				collision_shape_2d.owner = self

	# Apply data for editor preview
	if _hitbox_shape and is_instance_valid(collision_shape_2d):
		collision_shape_2d.shape = _hitbox_shape

#func _ready() -> void:
	## Runtime safety
	#if _main_texture and is_instance_valid(main_sprite):
		#main_sprite.texture = _main_texture
	#if _hitbox_shape and is_instance_valid(collision_shape_2d):
		#collision_shape_2d.shape = _hitbox_shape
