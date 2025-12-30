class_name GameOver
extends Control

signal new_game_requested
signal end_game_requested

const RIBBON_BLUE_3_SLIDES = preload("res://source/themes/ribbon_blue_3slides.tres")
const RIBBON_RED_3_SLIDES = preload("res://source/themes/ribbon_red_3slides.tres")

@onready var decline_button: TextureButton = %DeclineButton
@onready var accept_button: TextureButton = %AcceptButton
@onready var title_label: Label = %TitleLabel
@onready var title_panel: PanelContainer = %TitlePanel
@onready var play_again_label: Label = %PlayAgainLabel


func _ready() -> void:
	#set_victory()
	decline_button.pressed.connect(func(): end_game_requested.emit())
	accept_button.pressed.connect(func(): new_game_requested.emit())
	play_again_label.text = tr("PLAY_AGAIN_LABEL")

func set_game_over(victory: bool) -> void:
	if victory:
		title_label.text = tr("VICTORY_TOAST")
		title_panel.add_theme_stylebox_override("panel", RIBBON_BLUE_3_SLIDES)
	else:
		title_label.text = "GAME OVER"
		title_panel.add_theme_stylebox_override("panel", RIBBON_RED_3_SLIDES)
