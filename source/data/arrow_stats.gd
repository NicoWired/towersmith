class_name ArrowStats
extends Resource

var damage: Dictionary[StringName,Variant] = {
	"base_value": 10.0
	, "upgrade_level": 0
	, "upgrade_cost": [15,30,50,80,140,210]
}
var speed: Dictionary[StringName,Variant] = {
	"base_value": 1300.0
	, "upgrade_level": 0
	, "upgrade_cost": [10,15,25,40,60,85]
}

var stat_list: Dictionary[StringName, Dictionary] = {
	"damage": damage,
	"speed": speed
}

func get_damage() -> float:
	return damage["base_value"] + damage["base_value"] * damage["upgrade_level"]**2 * 0.1

func get_speed() -> float:
	return speed["base_value"] + speed["base_value"] * speed["upgrade_level"]**2 * 0.1

# not implemented
var crit_rate: float
var crit_multiplier: float
var ricochet: int
var fork: int
var projectile_amt: int
var pierce: int
var projectile_returns: bool
var chain: int
