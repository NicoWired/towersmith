class_name UpgradableStat
extends Control

signal stat_changed

var stat_name: String = "test"
var upgrade_level: int = 0
var max_level: int = 5
var upgrade_cost: Array = [1,2,3,4,5]
var name_translation: Dictionary[StringName,String] = {
	"tower_range": "Range"
	,"arrow_stats.damage": "Damage"
	,"arrow_stats.speed": "Speed"
	,"test": "Test"
}

@onready var stat_name_label: Label = %StatContainer/StatNameLabel
@onready var upgrade_level_label: Label = %StatContainer/UpgradeLevelLabel
@onready var upgrade_button: TextureButton = %StatContainer/UpgradeButton

func _ready() -> void:
	upgrade_button.pressed.connect(on_stat_upgrade)
	upgrade_level_label.text = str(upgrade_level)
	stat_name_label.text = name_translation[stat_name]

func on_stat_upgrade() -> void:
	if upgrade_level < max_level:
		var cost: int = upgrade_cost[upgrade_level]
		if cost <= Economy.current_gold:
			Economy.current_gold -= cost
			upgrade_level += 1
			upgrade_level_label.text = str(upgrade_level)
			stat_changed.emit(self)
