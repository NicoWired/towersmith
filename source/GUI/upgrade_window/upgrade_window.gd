class_name UpgradeWindow
extends Control

var building_to_upgrade: Tower
var base_upgradable_stat: UpgradableStat = preload("res://source/GUI/upgrade_window/upgradable_stat.tscn").instantiate()

@onready var close_button: TextureButton = %CloseButton
@onready var upgrades_container: GridContainer = %UpgradesContainer


func _ready() -> void:
	close_button.pressed.connect(on_close_pressed)
	custom_minimum_size = Vector2(1228,705)
	global_position = Vector2(253,206)

func update(input_building: Tower) -> void:
	for child in upgrades_container.get_children():
		child.queue_free()
	building_to_upgrade = input_building
	crate_upgradable_stats(building_to_upgrade.building_stats.stat_list)

func crate_upgradable_stats(stats_to_update: Dictionary, prefix:String = "") -> void:
	for stat_name: StringName in stats_to_update.keys():
		var stat = stats_to_update[stat_name]
		if stat is Resource:
			crate_upgradable_stats(stat.stat_list, prefix+stat_name+".")
		else:
			var new_stat: UpgradableStat = base_upgradable_stat.duplicate()
			new_stat.stat_name = prefix+stat_name
			new_stat.upgrade_level = int(stat[&"upgrade_level"])
			new_stat.max_level = stat[&"upgrade_cost"].size()
			new_stat.upgrade_cost = stat[&"upgrade_cost"]
			new_stat.stat_changed.connect(on_stat_changed)
			upgrades_container.add_child(new_stat)

func on_close_pressed() -> void:
	visible = false

func on_stat_changed(upgrade:UpgradableStat) -> void:
	var changed_stat: PackedStringArray = upgrade.stat_name.split(".")
	var stats_dict = building_to_upgrade.building_stats.stat_list
	for i in range(changed_stat.size() - 1):
		stats_dict = stats_dict[changed_stat[i]].stat_list
	var last_key = changed_stat[changed_stat.size() - 1]
	stats_dict[last_key]["upgrade_level"] = upgrade.upgrade_level
	building_to_upgrade.set_building_stats()
