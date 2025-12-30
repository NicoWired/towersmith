class_name SideMenu
extends PanelContainer

signal play_requested
signal pause_requested

@onready var master_bus_index: int = AudioServer.get_bus_index("Master")
@onready var gold_label: Label = %GoldLabel
@onready var mute_button: TextureButton = %MuteButton
@onready var pause_button: TextureButton = %PauseButton
@onready var play_button: TextureButton = %PlayButton

func _ready() -> void:
	mute_button.toggled.connect(on_mute_button_toggled)
	pause_button.toggled.connect(on_pause_button_toggled)
	play_button.pressed.connect(on_play_button_pressed)

func on_mute_button_toggled(toggled: bool) -> void:
	AudioServer.set_bus_mute(master_bus_index, toggled)

func on_pause_button_toggled(toggled: bool) -> void:
	pause_requested.emit(toggled)

func on_play_button_pressed() -> void:
	play_requested.emit()

func set_gold_label(gold: int) -> void:
	var gold_text: String
	var digits: int = len(str(gold))
	if digits in [1,2,3]:
		gold_text = str(gold)
	elif digits in [4,5,6]:
		@warning_ignore("integer_division")
		gold_text = str(gold/1000)+"K"
	elif digits in [7,8,9]:
		@warning_ignore("integer_division")
		gold_text = str(gold/1000000)+"M"
	elif digits in [10,11]:
		@warning_ignore("integer_division")
		gold_text = str(gold/1000000000)+"MM"
	else:
		gold_text = tr("TOO_MUCH_MONEY")
	gold_label.text = gold_text
