class_name Building
extends Node2D

signal upgrade_requested

var main_sprite: Sprite2D
var area_2d: Area2D
var collision_shape_2d: CollisionShape2D
var upgrades_button: TextureButton
var mouse_over_shader: ShaderMaterial

@export var main_texture: Texture2D
@export var hitbox_shape: Shape2D

func _enter_tree() -> void:
	add_to_group("buildings")
	
	# setup main sprite
	main_sprite = Sprite2D.new()
	main_sprite.name = "MainSprite"
	add_child(main_sprite)
	main_sprite.texture = main_texture

	# setup area for the hitbox
	area_2d = Area2D.new()
	area_2d.name = "HitboxArea"
	add_child(area_2d)

	# setup collision shape for the hitbox
	collision_shape_2d = CollisionShape2D.new()
	collision_shape_2d.name = "HitboxCollisionShape"
	collision_shape_2d.shape = hitbox_shape
	area_2d.add_child(collision_shape_2d)

	# setup shader
	mouse_over_shader = ShaderMaterial.new()
	mouse_over_shader.shader = preload("res://source/shaders/outline_shader.gdshader")
	mouse_over_shader.set_shader_parameter("width", 4.0)
	mouse_over_shader.set_shader_parameter("color", Color("1bff1c"))

	# create button for upgrades
	upgrades_button = TextureButton.new()
	upgrades_button.mouse_entered.connect(on_hover_entered)
	upgrades_button.mouse_exited.connect(on_hover_exited)
	upgrades_button.button_down.connect(on_upgrade_requested)
	add_child(upgrades_button)

func on_hover_entered() -> void:
	main_sprite.material = mouse_over_shader

func on_hover_exited() -> void:
	main_sprite.material = null

func on_upgrade_requested() -> void:
	upgrade_requested.emit()


func _ready() -> void:
	upgrades_button.custom_minimum_size = main_sprite.texture.get_size()
	# this shit is needed tp align the control node with the 2d nodes since they have a different (0,0)
	upgrades_button.position = Vector2(
			0 - upgrades_button.custom_minimum_size.x / 2.0
			, 0 - upgrades_button.custom_minimum_size.y / 2.0
		)
	on_hover_exited()
