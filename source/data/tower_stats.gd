class_name TowerStats
extends Resource

var arrow_stats: ArrowStats = ArrowStats.new()

var stat_list: Dictionary[StringName,Variant] = {
	"tower_range": {
		"base_vlaue": 150.0
		, "upgrade_level": 0
		, "upgrade_cost": [20,40,60,90]
	},
	"arrow_stats": arrow_stats
}
var tower_range: Dictionary = stat_list["tower_range"]

func get_tower_range() -> float:
	return tower_range["base_vlaue"] + tower_range["upgrade_level"] * 50

# not implemented
var aspd: float
