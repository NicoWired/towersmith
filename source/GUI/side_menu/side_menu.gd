class_name SideMenu
extends PanelContainer


@onready var gold_label: Label = %GoldLabel
@onready var mute_button: TextureButton = %MuteButton

func _ready() -> void:
	mute_button.toggled.connect(on_mute_button_toggled)
	
func on_mute_button_toggled(toggled: bool) -> void:
	for child in get_tree().get_nodes_in_group("sound"):
		child.stream_paused = toggled

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
		gold_text = "TOO MUCH"
	gold_label.text = gold_text
