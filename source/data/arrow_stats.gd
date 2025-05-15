class_name ArrowStats
extends Resource

var damage: Dictionary[StringName,float] = {
	"base_value": 10.0
	,"upgrade_level": 0
}
var speed: Dictionary[StringName,float] = {
	"base_value": 5.0
	,"upgrade_level": 0
}

var stat_list: Dictionary[StringName, Dictionary] = {
	"damage": damage,
	"speed": speed
}

func get_damage() -> float:
	return damage["base_value"] + damage["base_value"] * damage["upgrade_level"] * 0.1

func get_speed() -> float:
	return speed["base_value"] + speed["base_value"] * speed["upgrade_level"] * 0.1

# not implemented
var crit_rate: float
var crit_multiplier: float
var ricochet: int
var fork: int
var projectile_amt: int
var pierce: int
var projectile_returns: bool
var chain: int
