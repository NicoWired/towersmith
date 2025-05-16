class_name UpgradableStat
extends Control

signal stat_changed

var stat_name: String
var upgrade_level: int
var max_level: int
var upgrade_cost: Array
var name_translation: Dictionary[StringName,String] = {
	"tower_range": "Range"
	,"arrow_stats.damage": "Damage"
	,"arrow_stats.speed": "Speed"
}

@onready var stat_name_label: Label = $HBoxContainer/StatNameLabel
@onready var upgrade_level_label: Label = $HBoxContainer/UpgradeLevelLabel
@onready var upgrade_button: TextureButton = $HBoxContainer/UpgradeButton

func _ready() -> void:
	upgrade_button.pressed.connect(on_stat_upgrade)
	upgrade_level_label.text = str(upgrade_level)
	stat_name_label.text = name_translation[stat_name]

func on_stat_upgrade() -> void:
	if upgrade_level < max_level:
		var cost: int = upgrade_cost[upgrade_level]
		if cost <= Economy.current_gold:
			Economy.current_gold -= cost
			Economy.gold_changed.emit()
			upgrade_level += 1
			upgrade_level_label.text = str(upgrade_level)
			stat_changed.emit(self)
