class_name UpgradableStat
extends Control

signal stat_changed

var stat_name: String = "test"
var upgrade_level: int = 0
var max_level: int = 5
var upgrade_cost: Array = [1,2,3,4,5]
var name_translation: Dictionary[StringName,String] = {
	"tower_range": tr("TOWER_RANGE_STAT")
	,"arrow_stats.damage": tr("ARROW_DAMAGE_STAT")
	,"arrow_stats.speed": tr("ARROW_DAMAGE_SPEED")
	,"test": "Test"
}

@onready var stat_name_label: Label = %StatContainer/StatNameLabel
@onready var upgrade_level_label: Label = %StatContainer/UpgradeLevelLabel
@onready var upgrade_button: TextureButton = %StatContainer/UpgradeButton
@onready var cost_label: Label = $PanelContainer/MarginContainer/StatContainer/CostLabel


func _ready() -> void:
	upgrade_button.pressed.connect(on_stat_upgrade)
	upgrade_level_label.text = str(upgrade_level)
	stat_name_label.text = name_translation[stat_name] + ": "
	cost_label.text = set_cost_label_text()

func on_stat_upgrade() -> void:
	if upgrade_level < max_level:
		var cost: int = upgrade_cost[upgrade_level]
		if cost <= Economy.current_gold:
			Economy.current_gold -= cost
			upgrade_level += 1
			upgrade_level_label.text = str(upgrade_level)
			cost_label.text = set_cost_label_text()
			stat_changed.emit(self)

func set_cost_label_text() -> String:
	if upgrade_level == max_level:
		return("MAX")
	else:
		return(str(upgrade_cost[upgrade_level]))
